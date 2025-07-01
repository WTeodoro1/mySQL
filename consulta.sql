Use Restaurante;
select nome, categoria from Produtos where preco > 30;
select nome, data_nascimento, telefone from clientes where year (data_nascimento)<1985;
select id_produto, ingredientes from info_produtos where ingredientes like 'car%';
select nome, categoria from Produtos order by categoria asc, nome asc;
select preco, nome from Produtos order by preco desc limit 5;
select nome, categoria from Produtos where categoria = 'prato principal' order by categoria limit 2 offset 5;
create table back_pedidos select *from Pedidos;
