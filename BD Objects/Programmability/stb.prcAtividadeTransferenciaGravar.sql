-- =============================================
-- Create date: 24/03/2017
-- Description:	Gravação de Dados na Tabela 
--              tbAtividadeCorrecao
-- =============================================

CREATE PROCEDURE stb.[prcAtividadeTransferenciaGravar]		
	@p_id_atividade			NUMERIC(18,0) = NULL ,
	@p_dt_solicitacao		SMALLDATETIME = NULL ,
	@p_id_animal				INT = NULL, 
	@p_id_proprietario		INT = NULL, 
	@p_id_comprador			INT = NULL, 
	@p_prioritario			BIT	= NULL,
	@p_certificado_devolvido	BIT	= NULL,
	@p_dt_inicio_vigencia		SMALLDATETIME = NULL ,
	@p_dt_fim_vigencia			SMALLDATETIME = NULL ,
	@p_gerar_etiqueta_comprador			BIT	= NULL,
	@p_gerar_etiqueta_proprietario			BIT	= NULL,
	@p_id_usuario_alteracao NUMERIC(18,0)  = NULL ,
	@p_id_usuario_atualizacao	NUMERIC(18,0)	= NULL,
	@p_id_atividade_transferencia			NUMERIC(18,0)	OUTPUT

AS

BEGIN



	-- Declaração de Variáveis

	DECLARE @ds_error_message	NVARCHAR(4000),

			@id_error_severity	INT,

			@id_error_state		INT



	-- SET NOCOUNT ON added to prevent extra result sets from

	-- interfering with SELECT statements.

	SET NOCOUNT ON;



	BEGIN TRY



		BEGIN TRANSACTION

		

		IF ISNULL(@p_id_atividade_transferencia, 0) = 0

		BEGIN



			INSERT INTO stb.tbAtividadeTransferencia

				(			
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
				)

			VALUES

				(
					@p_id_atividade,
					@p_dt_solicitacao,
					@p_id_animal,
					@p_id_proprietario,
					@p_id_comprador,
					@p_prioritario,
					@p_certificado_devolvido,
					@p_dt_inicio_vigencia,
					@p_dt_fim_vigencia,
					@p_gerar_etiqueta_comprador,
					@p_gerar_etiqueta_proprietario,
					GETDATE(),
					@p_id_usuario_atualizacao,
					GETDATE(),
					@p_id_usuario_atualizacao

				)



			SET @p_id_atividade_transferencia = @@IDENTITY

	

		END

		ELSE BEGIN

			UPDATE	stb.tbAtividadeTransferencia

			SET		
				id_atividade = isnull(@p_id_atividade, id_atividade) , 
				dt_solicitacao = isnull(@p_dt_solicitacao, dt_solicitacao) ,
				id_animal = isnull(@p_id_animal, id_animal) ,
				id_proprietario = isnull(@p_id_proprietario, id_proprietario) ,
				id_comprador = isnull(@p_id_comprador, id_comprador) ,
				prioritario = isnull(@p_prioritario, prioritario) ,
				certificado_devolvido = isnull(@p_certificado_devolvido, certificado_devolvido) ,
				dt_inicio_vigencia = isnull(@p_dt_inicio_vigencia, dt_inicio_vigencia) ,
				dt_fim_vigencia = isnull(@p_dt_fim_vigencia, dt_fim_vigencia) ,
				gerar_etiqueta_comprador = isnull(@p_gerar_etiqueta_comprador, gerar_etiqueta_comprador) ,
				gerar_etiqueta_proprietario = isnull(@p_gerar_etiqueta_proprietario, gerar_etiqueta_proprietario) ,
				dt_alteracao = getdate() , 
				id_usuario_alteracao	= @p_id_usuario_atualizacao 

			WHERE	id_atividade_transferencia		= @p_id_atividade_transferencia

		END

		COMMIT TRANSACTION

	

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

		SELECT	@ds_error_message	= ERROR_MESSAGE(),
				@id_error_severity	= ERROR_SEVERITY(),
				@id_error_state		= ERROR_STATE();

		-- Use RAISERROR inside the CATCH block to return error
		-- information about the original error that caused
		-- execution to jump to the CATCH block.

		RAISERROR	(

					@ds_error_message,		-- Message text.
					@id_error_severity,		-- Severity.
					@id_error_state			-- State.

					)

	END CATCH

END