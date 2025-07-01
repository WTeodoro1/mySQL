use restaurante;


-- View do pedido completo
create view resumo_pedido as 
select pedidos.id_pedido, pedidos.quantidade,pedidos.data_pedido, clientes.nome as Cliente, clientes.email, funcionarios.nome as Atendente, produtos.nome , produtos.preco from pedidos
left join clientes on  pedidos.id_cliente = clientes.id_cliente
join funcionarios on pedidos.id_funcionario = funcionarios.id_funcionario
join produtos on produtos.id_produto= pedidos.id_Produto;

select *from resumo_pedido;
select id_pedido, cliente, sum(quantidade*preco)as valor_total from resumo_pedido
group by id_pedido;

-- Adiçao da coluna Total a View --
create or replace view resumo_pedido as 
select pedidos.id_pedido, pedidos.quantidade,pedidos.data_pedido, clientes.nome as Cliente, clientes.email, funcionarios.nome as Atendente, produtos.nome , produtos.preco,sum(quantidade*produtos.preco) as Total from pedidos
left join clientes on  pedidos.id_cliente = clientes.id_cliente
join funcionarios on pedidos.id_funcionario = funcionarios.id_funcionario
join produtos on produtos.id_produto= pedidos.id_Produto
group by id_pedido;


-- Nova consulta apos adiçao
select id_pedido, cliente, total from resumo_pedido;



-- Explain na view
explain select id_pedido, cliente, total from resumo_pedido;

-- procedimento armazenado
create procedure BuscaIngredientesProduto(id_produto int)
select id_info, ingredientes from info_produtos where id_produto= id_produto;
call BuscaIngredientesProduto(10);

drop procedure BuscaIngredientesProduto;

delimiter //
create function BuscaingredientesProduto(id_produto int)
returns varchar (200)
reads sql data
begin
 declare lista_de_ingredientes varchar(200);
SELECT 
    ingredientes
INTO lista_de_ingredientes FROM
    info_produtos
WHERE
    id_info = id_produto;
 return lista_de_ingredientes;
 end //
 delimiter ;
SELECT BUSCAINGREDIENTESPRODUTO(10);
  
 DELIMITER //

create function mediaPedido(id_pedido INT)
returns varchar(200)
reads sql data
begin
    declare nivel varchar(200);
    declare mediavendas decimal(10,2);
    select round(AVG(total), 2) into mediavendas from resumo_pedido where id_pedido = id_pedido;
select CASE
	WHEN r.total > mediavendas THEN 'acima'
	WHEN r.total < mediavendas THEN 'abaixo'
	WHEN r.total = mediavendas THEN 'igual'
END INTO nivel
    FROM resumo_pedido r
    WHERE r.id_pedido = id_pedido;
    RETURN nivel;

END //

DELIMITER ;
    select mediaPedido(6);
    select mediaPedido(5);