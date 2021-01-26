select idValidaA, count(idValidaA) as cuenta from gastoscarteraarchivos
where (select idValida  from depositados where gastoscarteraarchivos.idValidaA = depositados.idValida) 
group by idValidaA
order by cuenta desc
limit 1;
select concepto, tipoGasto, montoGasto from depositados
where montoGasto <= 1000
group by concepto
order by concepto asc, montoGasto asc;
select estado, sum(montoDeposito) as total from depositados
group by estado
order by total desc
limit 1;
select gastoscarteravalida.usuarioCargo, count(*) as total from gastoscarteravalida 
join gastoscarteradepositos on gastoscarteravalida.idValida = gastoscarteradepositos.idValidaD
WHERE gastoscarteradepositos.fechaDeposito BETWEEN '01/01/2019' and '31/12/2019' and gastoscarteravalida.comprobacion = 'NO'
GROUP BY gastoscarteravalida.usuarioCargo
order by total DESC;
select depositados.estado, count(depositados.numcred) as total  from depositados
left join movs on movs.numcred is null
group by depositados.estado
order by total desc;
select * from gastoscarteraarchivos
where idValidaA = "187612";
select * from depositados
where idValida = "187612";
