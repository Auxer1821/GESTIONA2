INSERT INTO ticket (fecha_hora, tipo_comprobante, subtotal_productos, total_descuento_aplicado, total_descuento_aplicado_mp, total_ticket, caja_numero, sucursal_id, pago_id)
VALUES ('2024-05-1 14:00:00', 'Factura A', 0, 0, 0, 0, NULL, NULL, NULL);

INSERT INTO producto (nombre, subcategoria_id, descripcion, precio_unitario, marca_id)
VALUES ('CHICLE', NULL, 'VIOLETA', 10, NULL);

INSERT INTO producto (nombre, subcategoria_id, descripcion, precio_unitario, marca_id)
VALUES ('CHOCOLATE', NULL, 'AMARGO', 100, NULL);

INSERT INTO producto (nombre, subcategoria_id, descripcion, precio_unitario, marca_id)
VALUES ('CHOCOLATE', NULL, 'LECHE', 90, NULL);

INSERT INTO detalle (producto_codigo, ticket_numero, cantidad)
VALUES (11, 18, 5);



update detalle 
set cantidad = 12
where detalle.producto_codigo = 11


DELETE FROM detalle
where producto_codigo = 13 and ticket_numero = 18
  

DROP TRIGGER IF EXISTS pago_update;
DROP TRIGGER IF EXISTS modificar_subtotal_ticket_al_insertar_detalle;

DROP function IF EXISTS Minimo;
DELETE FROM detalle;
DELETE FROM ticket;
DELETE FROM producto;
DELETE FROM promociones_aplicadas_al_detalle;

SELECT * FROM detalle 
SELECT * FROM ticket
select *from producto

SELECT *
FROM sys.triggers



-- Insertar filas en la tabla regla
INSERT INTO regla (cant_aplica_descuento/*a cuantos prod aplico*/, cant_aplica_regla/*cuantos prod nec*/, cant_max_prod/*cant veces*/, descripcion, descuento_aplicable_prod)
VALUES
(2, 4, 2, 'Descuento del 50% en la segunda unidad', 50.00);

INSERT INTO regla (cant_aplica_descuento/*a cuantos prod aplico*/, cant_aplica_regla/*cuantos prod nec*/, cant_max_prod/*cant veces*/, descripcion, descuento_aplicable_prod)
VALUES
( 1, 1, 1, 'Descuento del 100% en la misma unidad', 100.00);

-- Insertar filas en la tabla promocion
INSERT INTO promocion ( descripcion, fecha_inicio, fecha_fin, regla_id)
VALUES
( 'Promoción 1', '2024-01-01', '2024-12-31', 1)

INSERT INTO promocion ( descripcion, fecha_inicio, fecha_fin, regla_id)
VALUES
('Promoción 2', '2024-03-01', '2024-03-31', 2);

-- Insertar filas en la tabla promocion_por_producto
INSERT INTO promocion_por_producto (producto_codigo, codigo_promocion)
VALUES
(11, 1),
(2, 1),
(3, 1),
(4, 2);

delete promociones_aplicadas_al_detalle
where codigo_promocion = 1 and ticket_numero = 18 and producto_codigo = 11


SELECT * FROM detalle 
SELECT * FROM ticket
select *from producto
SELECT * FROM promociones_aplicadas_al_detalle 
SELECT * FROM regla


ALTER TABLE ticket
drop column pago_id

update ticket 
set total_descuento_aplicado = 0 
select * from ticket

