CREATE TABLE stb.AtividadeTransferencia
	(
	id_atividade_transferencia numeric(18, 0) NULL,
	id_atividade numeric(18, 0) NULL,
	dt_solicitacao datetime NULL,
	id_animal int NULL,
	id_proprietario int NULL,
	id_comprador int NULL,
	prioritario bit NULL,
	certificado_devolvido bit NULL,
	dt_inicio_vigencia datetime NULL,
	dt_fim_vigencia datetime NULL,
	gerar_etiqueta_comprador bit NULL,
	gerar_etiqueta_proprietario bit NULL,
	dt_inclusao datetime NULL,
	id_usuario_inclusao numeric(18, 0) NULL,
	dt_alteracao datetime NULL,
	id_usuario_alteracao numeric(18, 0) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE stb.AtividadeTransferencia SET (LOCK_ESCALATION = TABLE)
GO
