

-- =============================================

-- Create date: 24/03/2017

-- Description:	Consulta por ID da Tabela de

--				tbAtividadeTransferencia

-- =============================================

CREATE PROCEDURE stb.[prcAtividadeTransferenciaGetById]
(
	@p_id_atividade_transferencia		NUMERIC(18,0)
)

AS

BEGIN		

	

	SET NOCOUNT ON;	



	SELECT	
				id_atividade_transferencia,
				id_atividade,
				dt_solicitacao,
				id_animal,
				id_proprietario,
				id_comprador,
				prioritario,
				certificado_devolvido,
				dt_inicio_vigencia,
				dt_fim_vigencia,
				gerar_etiqueta_comprador,
				gerar_etiqueta_proprietario,
				dt_inclusao,
				id_usuario_inclusao,
				dt_alteracao,
				id_usuario_alteracao

		,ROW_NUMBER() OVER(ORDER BY id_atividade_transferencia) as intRow

	FROM	

		stb.tbAtividadeTransferencia

	WHERE 

		id_atividade_transferencia = @p_id_atividade_transferencia

END

