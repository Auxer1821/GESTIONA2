-----------------------------------------------------DETALLES
CREATE PROCEDURE ActualizarSubtotalTicket
    @TicketNumero INT
AS
BEGIN
    -- Recalcular el subtotal_productos para el ticket especificado
    UPDATE t
    SET subtotal_productos = (
        SELECT SUM(total)
        FROM detalle
        WHERE ticket_numero = @TicketNumero
    )
    FROM ticket t
    WHERE t.ticket_numero = @TicketNumero;
END;


CREATE TRIGGER modificar_subtotal_ticket_al_insertar_detalle
ON detalle
AFTER INSERT
AS
BEGIN
    DECLARE @TicketNumero INT;
    
    -- Obtener el ticket_numero de los registros insertados
    SELECT @TicketNumero = ticket_numero FROM inserted;
    
    -- Llamar al procedimiento para actualizar el subtotal
    EXEC ActualizarSubtotalTicket @TicketNumero;
END;



CREATE TRIGGER calcular_total_y_subtotal_actualizar
ON detalle
AFTER UPDATE
AS
BEGIN
    DECLARE @TicketNumero INT;
    
    -- Actualización de la tabla 'detalle' con el nuevo total
    UPDATE d
    SET d.total = i.precio_unitario * i.cantidad
    FROM detalle d
    JOIN inserted i ON d.producto_codigo = i.producto_codigo
                   AND d.ticket_numero = i.ticket_numero;

    -- Obtener el ticket_numero de los registros actualizados
    SELECT @TicketNumero = ticket_numero FROM inserted;
    
    -- Llamar al procedimiento para actualizar el subtotal
    EXEC ActualizarSubtotalTicket @TicketNumero;
END;

CREATE TRIGGER ajustar_detalle_precio_unitario_y_total
ON detalle
INSTEAD OF INSERT
AS
BEGIN
	-- Insertar en la tabla 'detalle' ajustando el precio_unitario y 
    INSERT INTO detalle (producto_codigo, ticket_numero, cantidad, precio_unitario, total)
    SELECT 
        i.producto_codigo,
        i.ticket_numero,
        ISNULL(i.cantidad, 0),
        ISNULL(i.precio_unitario, 0),
        ISNULL(i.cantidad * i.precio_unitario, 0)
    FROM inserted i
END; 

CREATE TRIGGER eliminar_detalle_modificar_ticket
ON detalle
AFTER DELETE
AS
BEGIN
    DECLARE @TicketNumero INT;
    
    -- Obtener el ticket_numero de los registros eliminados
    SELECT @TicketNumero = ticket_numero FROM deleted;
    
    -- Llamar al procedimiento para actualizar el subtotal
    EXEC ActualizarSubtotalTicket @TicketNumero;
END;

CREATE TRIGGER ticket_total
ON ticket
AFTER UPDATE
AS
BEGIN
	UPDATE ticket
	SET total_ticket = ISNULL(subtotal_productos, 0) - ISNULL(total_descuento_aplicado, 0) - ISNULL(total_descuento_aplicado_mp, 0)
END;


-------------------------------------------------PROMOCIONES
CREATE FUNCTION dbo.Minimo(@num1 INT, @num2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @min INT;
    
    IF @num1 < @num2
        SET @min = @num1;
    ELSE
        SET @min = @num2;
    
    RETURN @min;
END;

CREATE TRIGGER insert_promocion_aplicada_detalle
ON promociones_aplicadas_al_detalle
AFTER INSERT
AS
BEGIN
     -- Actualización de la tabla 'ticket' con el nuevo subtotal_productos. 
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado +  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN inserted i ON t.ticket_numero = i.ticket_numero
	join promocion p on p.codigo_promocion = i.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = i.producto_codigo
	join detalle d on d.producto_codigo = i.producto_codigo
                   AND d.ticket_numero = i.ticket_numero;
	
END;

/*
CREATE TRIGGER update_promocion_aplicada_detalle
ON promociones_aplicadas_al_detalle
AFTER UPDATE
AS
BEGIN
     -- Actualización de la tabla 'ticket' con el nuevo subtotal_productos. 
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado -  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN deleted dl ON t.ticket_numero = dl.ticket_numero
	join promocion p on p.codigo_promocion = dl.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = dl.producto_codigo
	join detalle d on d.producto_codigo = dl.producto_codigo
                   AND d.ticket_numero = dl.ticket_numero;
    
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado +  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN inserted i ON t.ticket_numero = i.ticket_numero
	join promocion p on p.codigo_promocion = i.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = i.producto_codigo
	join detalle d on d.producto_codigo = i.producto_codigo
                   AND d.ticket_numero = i.ticket_numero;
END;*/

CREATE TRIGGER delete_promocion_aplicada_detalle
ON promociones_aplicadas_al_detalle
AFTER delete
AS
BEGIN
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado -  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN deleted dl ON t.ticket_numero = dl.ticket_numero
	join promocion p on p.codigo_promocion = dl.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = dl.producto_codigo
	join detalle d on d.producto_codigo = dl.producto_codigo
                   AND d.ticket_numero = dl.ticket_numero;
  end; 
------------------------------------------------------PAGO
CREATE TRIGGER	pago_insert
ON pago
AFTER INSERT
AS
BEGIN
		UPDATE t 
		SET total_descuento_aplicado_mp += dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100)
		FROM ticket t
		JOIN inserted i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id
END;

CREATE TRIGGER	pago_update
ON pago
AFTER UPDATE
AS
BEGIN
		UPDATE t 
		SET total_descuento_aplicado_mp +=  dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100)
		FROM ticket t
		JOIN inserted i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id

		UPDATE t 
		SET total_descuento_aplicado_mp -= dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
		FROM ticket t
		JOIN DELETED i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id
END;

CREATE TRIGGER	pago_delete
ON pago
AFTER delete
AS
BEGIN
		UPDATE ticket 
		SET total_descuento_aplicado_mp -=dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
		FROM ticket t
		JOIN DELETED i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id
END;
-------------------------------------------------------------------definicion_descuento

CREATE TRIGGER definicion_descuento_update
ON definicion_descuento
AFTER UPDATE
AS
BEGIN
	UPDATE t
	SET total_descuento_aplicado_mp += dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
	FROM ticket t
	JOIN pago p ON p.ticket_numero = t.ticket_numero
	JOIN descuento_por_medio_de_pago_aplicado dpmdpa ON dpmdpa.dpmdpa_id = p.dpmdpa_id
	JOIN inserted i ON i.definicion_id = dpmdpa.definicion_id

	UPDATE t
	SET total_descuento_aplicado_mp -= dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
	FROM ticket t
	JOIN pago p ON p.ticket_numero = t.ticket_numero
	JOIN descuento_por_medio_de_pago_aplicado dpmdpa ON dpmdpa.dpmdpa_id = p.dpmdpa_id
	JOIN deleted i ON i.definicion_id = dpmdpa.definicion_id
END;