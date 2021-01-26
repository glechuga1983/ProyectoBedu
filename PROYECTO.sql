use pruebas2;
select gastoscarteravalida.usuarioCargo, count(*) from gastoscarteravalida 
inner join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValida 
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '01/01/2019' and '31/12/2019'
group by gastoscarteravalida.usuarioCargo;
describe gastoscarteravalida;
select usuario.ds_nombre, count(*) from gastoscarteravalida 
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
RIGHT JOIN usuario on gastoscarteravalida.usuarioCargo = usuario.ds_nick
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '01/01/2019' and '31/12/2019'
group by usuario.ds_nombre;
select * from gastoscarteravalida
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '2019-01-01' and '2019-12-31';
-- crear vista 1
create view depositados as 
 (select * from gastoscarteravalida
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '2019-01-01' and '2019-12-31');
-- -	¿Qué usuarios tienen más Gastos sin comprobar 2019?
select gastoscarteravalida.usuarioCargo, count(*) as total from gastoscarteravalida 
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '01/01/2019' and '31/12/2019' and gastoscarteravalida.comprobacion = 'NO'
GROUP BY gastoscarteravalida.usuarioCargo
order by total DESC;
-- - -	¿Qué estados tienen gastos comprobados que no implicaron movimiento procesal en 2019?
select depositados.estado, depositados.numcred, depositados.fechaDeposito, depositados.concepto,  movs.numcred from depositados
left join movs on movs.numcred = null
;
--  -	¿Cuáles son los montos más altos de gastos autorizados por estado que no fueron comprobados?
select estado, montoGasto, comprobacion, fechaDeposito, concepto
from depositados
where comprobacion = 'NO'
order by montoGasto desc;

-- -	¿Qué estados tienen gastos comprobados que no implicaron movimiento procesal en 2019? 
select depositados.estado, depositados.numcred,  asignacion.acreditado, asignacion.numcred from depositados
left join asignacion on asignacion.acreditado = null;
-- -	¿Cuál es el monto de gastos depositados por mes?
select month(fechaDeposito) as mes, sum(montoDeposito) from depositados
group by mes
;



