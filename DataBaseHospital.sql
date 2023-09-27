create database if not exists BDHospital;

use BDHospital;

create table if not exists Especialidade(
	id_especialidade int(11) auto_increment primary key,
    nome_especialidade varchar(100)
);

create table if not exists convenio(
	id_convenio int(11) auto_increment primary key,
    nome_convenio varchar(100),
    cnpj_convenio varchar(14),
    tempo_carencia varchar(100)
);

CREATE TABLE IF NOT EXISTS medico(
	id_medico int(11) auto_increment primary key,
    nome_medico varchar(125) not null,
    cpf_medico int(15) unique not null,
    crm varchar(13)unique not null,
    email_medico varchar(100),
    cargo varchar(100) NOT NULL,
    especialidade_id INT NOT NULL,
    foreign key(especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade 
);

create table if not exists paciente(
	id_paciente int(11) auto_increment primary key,
    nome_paciente varchar(125) not null,
    dt_nasc_paciente date,
    cpf_paciente int(15) unique not null,
    rg_paciente varchar(11) not null,
    email_paciente varchar(100),
    convenio_id int(11) default null,
    foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade 
);

create table if not exists enfermeiro(
	id_enfermeiro int(11) auto_increment primary key,
    nome_enfermeiro varchar(125) not null,
    cpf_enfermeiro int(11) unique not null,
    cre varchar(13)unique not null
);

create table if not exists consulta(
	id_consulta int(11) auto_increment primary key,
    data_consulta date not null,
    hora_consulta time not null,
    valor_consulta decimal,
    convenio_id int(11) default null,
    medico_id int(11) not null,
    paciente_id int(11) not null,
    especialidade_id int(11) not null,
    foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade
);

create table if not exists receita(
	id_receita int(11) auto_increment primary key,
    medicamento varchar(200),
    qtd_medicamento int(11),
    instrucao_uso text(220),
    consulta_id int(11) not null,
    foreign key(consulta_id) references consulta (id_consulta) on delete cascade on update cascade
);

create table if not exists tipo_quarto(
	id_tipo int(11) auto_increment primary key,
    valor_diario decimal(8, 2) not null,
    desc_quarto varchar(100) default null
);

create table if not exists quarto(
	id_quarto int(11) auto_increment primary key,
    numero int(11) not null,
    tipo_id int(11) not null,
    foreign key(tipo_id) references tipo_quarto (id_tipo) on delete cascade on update cascade
);

create table if not exists internacao(
	id_internacao int(11) auto_increment primary key,
    data_entrada date not null,
    data_prev_alta date not null,
    data_efet_alta date not null,
    desc_procedimentos text,
    paciente_id int(11) not null,
    medico_id int(11) not null,
    quarto_id int(11) not null, 
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade,
    foreign key(quarto_id) references quarto (id_quarto) on delete cascade on update cascade
);

create table if not exists plantao(
	id_plantao int(11) auto_increment primary key,
    data_plantao date,
    hora_plantao time,
    internacao_id int(11) not null,
    enfermeiro_id int(11) not null,
    foreign key(internacao_id) references internacao (id_internacao) on delete cascade on update cascade,
    foreign key(enfermeiro_id) references enfermeiro (id_enfermeiro) on delete cascade on update cascade
);

create table if not exists endereco(
	id_endereco int(11) auto_increment primary key,
    logradouro varchar(100) not null,
    cep int(8)not null,
    bairro varchar(100) not null,
    cidade varchar(100)not null,
    estado varchar(100)not null,
    medico_id int(11) default null,
    paciente_id int(11) default null,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade
);

create table if not exists telefone(
	id_telefone int(11) auto_increment primary key,
    ddd int(3) not null,
    numero int(9) not null,
    medico_id int(11) default null,
    paciente_id int(11) default null,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade
);

-- Inserindo dados na tabela Convenio
--
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(1, 'SulAmerica', '15963214589615', '36 dias');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(2, 'Unimed', '35789654123015', '96 horas');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(3, 'Bradesco', '69857423987463', '240 dias');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(4, 'Notredame', '65489632154785', '90 dias');


-- Inserindo dados na tabela Especialidade
--
insert into especialidade(id_especialidade, nome_especialidade) values(1, 'Cardiologia');
insert into especialidade(id_especialidade, nome_especialidade) values(2, 'Clínica');
insert into especialidade(id_especialidade, nome_especialidade) values(3, 'Dermatologia');
insert into especialidade(id_especialidade, nome_especialidade) values(4, 'Gastroenterologia');
insert into especialidade(id_especialidade, nome_especialidade) values(5, 'Ginecologia');
insert into especialidade(id_especialidade, nome_especialidade) values(6, 'Neurologia');
insert into especialidade(id_especialidade, nome_especialidade) values(7, 'Pediatria');


-- Inserindo dados na tabela Tipo de quarto
--
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(1, '100', 'Quartos duplos');
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(2, '70', 'Apartamentos');
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(3, '600', 'Enfermaria');


-- Inserindo dados na tabela Medico
--
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(1, 'Lucas Oliveira', 6987458963, 963852, 'lucas@gmail.com', 'Residente', 5); 
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(2, 'Lucas Cruz', '7896541231', '456987', 'cruz@gmail.com', 'Interno', 1);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(3, 'Bleiderson Amaral', '6457899564', '365415', 'bleide@gmail.com', 'Residente', 6);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(4, 'Thaina Patricia', '9657841256', '951856', 'thaina@gmail.com', 'Especialista', 6);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(5, 'Jose Carvalho', '3648959635', '959879', 'zeca@hotmail.com', 'Residente', 6);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(6, 'Maria Ines', '6597485631', '784898', 'maria@gmail.com', 'Residente', 4);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(7, 'Matheus Americo', '1569654885', '565656', 'matheus@gmail.com', 'Especialista', 2);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(8, 'Gustavo Pinheiro', '6526894598', '363636', 'gustavo@gmail.com', 'Especialista', 1);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(9, 'Daniele Alves', '1245789865', '585858', 'daniele@gmail.com', 'Interno', 3);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(10, 'Renato Ribeiro', '6578983215', '595959', 'renato@gmail.com', 'Residente', 2);


-- Inserindo dados na tabela Paciente
--
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(1, 'Naomi', '1999-09-26', '78787878', '787878-6', 'naomi@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(2, 'Ketlyn', '1999-09-26', '89898989', '898989-6', 'ket@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(3, 'Crystian', '1999-09-26', '45454545', '454545-5', 'crys@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(4, 'Marco', '1999-09-26', '58585858', '585858-8', 'marco@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(5, 'Vinicius', '1999-09-26', '25252525', '252525-5', 'vinicius@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(6, 'Camila', '1999-09-26', '35353535', '353535-5', 'camila@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(7, 'Deborah', '1999-09-26', '15151515', '151515-5', 'deborah@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(8, 'joao', '1999-09-26', '52525252', '525252-5', 'joao@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(9, 'Pedro', '1999-09-26', '18181818', '181818-8', 'pedro@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(10, 'Andreia', '1999-09-26', '49494949', '494949-9', 'picin@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(11, 'Carlos', '1999-09-26', '60606060', '606060-0', 'caverna@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(12, 'Lucas', '1999-09-26', '27272727', '272727-7', 'lucas27@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(13, 'Virginia', '1999-09-26', '10101011', '111111-1', 'virgi@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(14, 'Julio', '1999-09-26', '17171717', '171171-1', 'julinho@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(15, 'Paula', '1999-09-26', '50150150', '505150-1', 'paula@gmail.com', null);


-- Inserindo dados na tabela Telefone
--
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(1, 11, 78978978, 1, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(2, 11, 98798798, 2, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(3, 11, 65445665, 3, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(4, 11, 45645645, 4, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(5, 11, 32112332, 5, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(6, 11, 12312312, 6, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(7, 11, 32323232, 7, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(8, 11, 14253625, 8, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(9, 11, 36251414, 9, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(10, 11, 74747474, 10, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(11, 11, 95959595, null, 1);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(12, 11, 74859658, null, 2);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(13, 11, 25262426, null, 3);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(14, 11, 14151415, null, 4);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(15, 11, 14151425, null, 5);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(16, 11, 91456798, null, 6);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(17, 11, 47856986, null, 7);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(18, 11, 61598456, null, 8);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(19, 11, 34597861, null, 9);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(20, 11, 64658978, null, 10);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(21, 11, 14168522, null, 11);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(22, 11, 65985213, null, 12);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(23, 11, 14524267, null, 13);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(24, 11, 24728577, null, 14);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(25, 11, 36504015, null, 15);


-- Inserindo dados na tabela Endereco
--
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(1, 'Rua Andreus', 05210-003, 'Jardins', 'São Paulo', 'São Paulo', null, 1);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(2, 'R. Gassani', 04532-082, 'Consolação', 'São Paulo', 'São Paulo', null, 2);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(3, 'Rua Luiza', 05018-020, 'Boa Vista', 'São Paulo', 'São Paulo', null, 3);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(4, 'R. Manuela',  3325-3181 , 'Campo Limpo', 'São Paulo', 'São Paulo', 1, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(5, 'R. Aurora', 01508-001, 'Sé', 'São Paulo', 'São Paulo', 2, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(6, 'R. Joaquim', 01423-010, 'Butantã', 'São Paulo', 'São Paulo', 3, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(7, 'R. Eduardo', 04005-001, 'Barra Funda', 'São Paulo', 'São Paulo', 4, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(8, 'R. Estrelas', 05509-001, 'Vila Sonia', 'São Paulo', 'São Paulo', 5, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(9, 'R. Oscar', 02577-020, 'Luz', 'São Paulo', 'São Paulo', 6, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(10, 'R. doze', 05315-010, 'Lapa', 'São Paulo', 'São Paulo', 7, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(11, 'R. onze', 05049-030, 'Casa Verde', 'São Paulo', 'São Paulo', null, 8);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(12, 'R. Sylvio', 01325-001, 'Freguesia', 'São Paulo', 'São Paulo', null, 9);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(13, 'Av. Luiz de Camões', 16400-050, 'Pirituba', 'São Paulo', 'São Paulo', null, 10);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(14, 'R. Tereza', 07070-111, 'Saúde', 'Guarulhos', 'São Paulo', 8, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(15, 'R. Conceição', 02335-001, 'Belém', 'São Paulo', 'São Paulo', 9, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(16, 'Av. Felipe', 02065-010, 'Tatuapé', 'São Paulo', 'São Paulo', 10, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(17, 'R. Cesar', 02114-001, 'Ipiranga', 'São Paulo', 'São Paulo', null, 4);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(18, 'Av. Henrique', 03028-050, 'Mooca', 'São Paulo', 'São Paulo', null, 5);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(19, 'R. Naldo', 03016-010, 'Morumbi', 'São Paulo', 'São Paulo', null, 6);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(20, 'R. Cirillo', 0659-511, 'Ceasa', 'São Paulo', 'São Paulo', null, 7);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(21, 'R. Mirela', 01154-000, 'Liberdade', 'São Paulo', 'São Paulo', null, 11);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(22, 'R. Heloisa', 02555-000, 'Armênia', 'São Paulo', 'São Paulo', null, 12);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(23, 'Av. Leticia', 02543-010, 'Tucuruvi', 'São Paulo', 'São Paulo', null, 13);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(24, 'Av. Machado', 02464-600, 'Paraiso', 'São Paulo', 'São Paulo', null, 14);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(25, 'Andressa', 03206-010, 'Santa Cecilia', 'São Paulo', 'São Paulo', null, 15);


-- Inserindo dados na tabela Enfermeiro
--
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(1, 'Baltazar', 03657289, '489589');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(2, 'Amaro', 22335557, '321230');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(3, 'Bernardo', 65756757, '233232');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(4, 'André', 15159600, '198789');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(5, 'Julieta', 02610206, '694701');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(6, 'Matilde', 90870887, '011664');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(7, 'Mariana', 90807090, '690490');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(8, 'Sonia', 20689069, '698506');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(9, 'Aguiar', 0798560, '609070');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(10, 'Clarice', 65095069, '065496');


-- Inserindo dados na tabela Consulta
--
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(1, '2016-09-25', '15:40:00', '300.00', 1, 6, 2, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(2, '2018-12-09', '08:00:00', '300.00', 2, 5, 7, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(3, '2021-10-03', '09:30:00', '150.00', 3, 4, 5, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(4, '2023-02-10', '12:30:00', '180.00', 4, 3, 11, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(5, '2015-02-10', '12:00:00', '350.00', 1, 2, 14, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(6, '2016-01-30', '13:00:00', '260.00', 2, 1, 1, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(7, '2019-06-13', '13:30:00', '150.00', 3, 7, 14, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(8, '2018-01-01', '13:30:00', '180.00', 4, 8, 13, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(9, '2019-07-14', '13:30:00', '300.00', null, 9, 12, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(10, '2020-05-08', '16:00:00', '150.00', null, 10, 11, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(11, '2020-11-16', '07:20:00', '260.00', null, 1, 10, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(12, '2015-12-07', '07:00:00', '300.00', null, 2, 9, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(13, '2016-11-12', '08:40:00', '300.00', null, 3, 8, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(14, '2015-02-20', '10:25:00', '250.00', 1, 4, 7, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(15, '2016-02-20', '15:00:00', '250.00', 2, 5, 6, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(16, '2022-02-20', '09:00:00', '230.00', 3, 6, 5, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(17, '2022-08-22', '16:20:00', '150.00', 4, 7, 4, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(18, '2023-01-01', '15:20:00', '150.00', 1, 8, 3, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(19, '2023-02-15', '16:00:00', '100.00', 2, 9, 2, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(20, '2023-11-29', '16:00:00', '250.00', 3, 10, 1, 5);


-- Inserindo dados na tabela Receita
--
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(2, 'Tylenol', '2', 'Tomar um comprimido ao dia', 1);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(11, 'Dorflex', '2', 'Tomar um comprimido ao dia', 2);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(1, 'Anador', '2', 'Tomar um comprimido ao dia', 3);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(3, 'Gliface', '2', 'Tomar um comprimido ao dia', 4);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(4, 'Sanxeda ', '2', 'Tomar um comprimido ao dia', 5);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(5, 'Xarope', '2', 'Tomar um comprimido ao dia', 6);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(6, 'Ivermectina', '2', 'Tomar um comprimido ao dia', 7);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(7, 'Omeprazol', '2', 'Tomar um comprimido ao dia', 8);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(8, 'Dipirona', '2', 'Tomar um comprimido ao dia', 9);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(9, 'Tylenol', '2', 'Tomar um comprimido ao dia', 10);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(10, 'Omeprazol', '2', 'Tomar um comprimido ao dia', 11);


-- Inserindo dados na tabela Quarto
--
insert into quarto(id_quarto, numero, tipo_id) values(1, 06, 3);
insert into quarto(id_quarto, numero, tipo_id) values(2, 07, 3);
insert into quarto(id_quarto, numero, tipo_id) values(3, 08, 3);
insert into quarto(id_quarto, numero, tipo_id) values(4, 09, 1);
insert into quarto(id_quarto, numero, tipo_id) values(5, 10, 2);


-- Inserindo dados na tabela Internacao
--
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (1, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 10, 1, 1);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (2, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 9, 2, 3);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (3, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 8, 3, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (4, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 7, 4, 1);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (5, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 6, 5, 3);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (6, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 5, 6, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (7, '2023-09-27', '2023-09-27', '2023-09-27', 'Acompanhar evolução', 4, 7, 1);


-- Inserindo dados na tabela Plantão
--
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (1, '2023-09-27', '15:00:00', 2, 1);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (2, '2023-09-27', '14:30:00', 2, 2);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (3, '2023-09-27', '13:00:00', 1, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (4, '2023-09-27', '12:30:00', 1, 4);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (5, '2023-09-27', '11:00:00', 3, 5);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (6, '2023-09-27', '10:30:00', 3, 6);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (7, '2023-09-27', '09:00:00', 3, 7);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (8, '2023-09-27', '08:30:00', 2, 8);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (9, '2023-09-27', '07:00:00', 6, 9);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (10, '2023-09-27', '18:30:00', 1, 10);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (11, '2023-09-27', '22:00:00', 3, 1);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (12, '2023-09-27', '20:30:00', 4, 2);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (13, '2023-09-27', '17:00:00', 5, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (14, '2023-09-27', '16:30:00', 5, 4);


-- Adicionando mais uma coluna 'em_atividade' na tabela medico
--
alter table medico add em_atividade varchar(100);

update medico set em_atividade = 'Inativo' where id_medico = 1;
update medico set em_atividade = 'Ativo' where id_medico = 2;
update medico set em_atividade = 'Inativo' where id_medico = 3;
update medico set em_atividade = 'Ativo' where id_medico = 4;
update medico set em_atividade = 'Inativo' where id_medico = 5;
update medico set em_atividade = 'Ativo' where id_medico = 6;
update medico set em_atividade = 'Inativo' where id_medico = 7;
update medico set em_atividade = 'Ativo' where id_medico = 8;
update medico set em_atividade = 'Inativo' where id_medico = 9;
update medico set em_atividade = 'Ativo' where id_medico = 10;


-- Consultando o banco
--

-- 1 
select *, AVG(valor_consulta) from consulta group by year(data_consulta) = 2020 having convenio_id;


-- 2 
select * from internacao where data_efet_alta > data_prev_alta;


-- 3 
select * from consulta inner join receita on consulta.id_consulta = receita.consulta_id inner join paciente 
on paciente.id_paciente = consulta.paciente_id 
order by receita.id_receita limit 1;


-- 4 
select *, MAX(valor_consulta), MIN(valor_consulta) from consulta group by convenio_id is null;


-- 5 
select *, DATEDIFF(data_efet_alta, data_entrada) dias_internado, tipo_quarto.valor_diario, DATEDIFF(data_efet_alta, data_entrada) * tipo_quarto.valor_diario valor_total from internacao inner join quarto 
on internacao.quarto_id = quarto.id_quarto inner join tipo_quarto 
on quarto.tipo_id = tipo_quarto.id_tipo;


-- 6 
select i.id_internacao, i.data_entrada, i.desc_procedimentos, q.numero from internacao i inner join quarto q 
on q.id_quarto = i.quarto_id where q.tipo_id = 1; 


-- 7 
select p.nome_paciente, c.data_consulta, e.nome_especialidade from consulta c inner join paciente p 
on p.id_paciente = c.paciente_id inner join especialidade e 
on e.id_especialidade = c.especialidade_id 
where c.especialidade_id <> 1 and year(c.data_consulta) - year(p.dt_nasc_paciente) < 19 and year(c.data_consulta) - year(p.dt_nasc_paciente) > 0 
order by c.data_consulta ;


-- 8
select p.nome_paciente, m.nome_medico, i.data_entrada, i.desc_procedimentos, q.id_quarto
from internacao i
inner join medico m 
on m.id_medico = i.medico_id
inner join paciente p
on p.id_paciente = i.paciente_id
inner join quarto q
on q.id_quarto = i.quarto_id
where q.tipo_id = 3 and m.especialidade_id = 3;


-- 9 
select m.nome_medico, m.crm, count(c.medico_id) as 'Qntd de consultas' from medico m inner join consulta c 
on c.medico_id = m.id_medico group by c.medico_id;


-- 10 
insert into medico(nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id, em_atividade) values('Xande', 15351535, 956874, 'xande@gmail.com', 'Residente', 2, 'Ativo');
insert into endereco(logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values('R. Xangu', 05657-000, 'Brás', 'São Paulo', 'São Paulo', 11, null);
insert into telefone(ddd, numero, medico_id, paciente_id) values(11, 959596547, 11, null);

select * from medico where nome_medico like 'Xande1';


-- 11 
select enf.nome_enfermeiro, enf.cre, COUNT(p.enfermeiro_id) as Participacao from enfermeiro enf
inner join plantao p on p.enfermeiro_id = enf.id_enfermeiro group by enf.id_enfermeiro having Participacao > 1;

