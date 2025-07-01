use Restaurante;
select *from Pedidos;
select id_funcionario, estatus from Pedidos where id_funcionario = 4 and estatus = 'pendente';
select *from Pedidos where not estatus = 'concluido';
select *from Pedidos where id_produto in (1,3,5, 7, 8);
select *from clientes where nome like 'c%';
select *from info_produtos where ingredientes like 'frang%' or ingredientes like 'carn%';
select *from Produtos where preco between 20 and 30;
update pedidos
set estatus = null
where id_pedido = '6';
select *from Pedidos where estatus is null;
select id_pedido,ifnull(estatus, 'Cancelado') from Pedidos;
select nome, cargo, salario,
case
 when salario > 3000 then 'acima da media'
 else'abaixo da media'
 end as media_salario
 from Funcionarios;
 select nome, cargo, salario, if(salario>3000,'acima da media', 'abaixo da media') as media_salario from funcionarios;