-- =============================================
-- Create date: 24/03/2017
-- Description:	Seleção de dados na tabela 
--              tbAtividadeTransferencia 
-- =============================================

CREATE PROCEDURE stb.[prcAtividadeTransferenciaSelect]
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
	@p_id_atividade_transferencia			NUMERIC(18,0)	OUTPUT,
	@p_page_index				INT = NULL,
	@p_page_size				INT = NULL,
	@p_order_by				VARCHAR(50) = 'id_atividade_correcao',
	@P_order_by_direction		VARCHAR(1) = 'A',
	@p_total_rows				NUMERIC(18,0) OUTPUT	

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

		DECLARE @intStartRow INT = NULL

		DECLARE @intEndRow INT = NULL



		IF(@p_page_index IS NOT NULL AND @p_page_size IS NOT NULL)

		BEGIN

			BEGIN

				SELECT @intStartRow = (@p_page_index * @p_page_size) + 1
				SELECT @intEndRow = (@p_page_index + 1) * @p_page_size 

			END

		END

		

		SELECT	

			@p_total_rows = COUNT(*)	

		FROM	stb.tbAtividadeTransferencia (nolock)

		WHERE	

				  ( @p_id_atividade_transferencia IS NULL OR id_atividade_transferencia = @p_id_atividade_transferencia) 
			 AND   ( @p_id_atividade IS NULL OR id_atividade = @p_id_atividade) 
			 AND   ( @p_dt_solicitacao IS NULL OR dt_solicitacao = @p_dt_solicitacao) 
			 AND   ( @p_id_animal IS NULL OR id_animal = @p_id_animal) 
			 AND   ( @p_id_proprietario IS NULL OR id_proprietario = @p_id_proprietario) 
			 AND   ( @p_id_comprador IS NULL OR id_comprador = @p_id_comprador) 
			 AND   ( @p_prioritario IS NULL OR prioritario = @p_prioritario) 
			 AND   ( @p_certificado_devolvido IS NULL OR certificado_devolvido = @p_certificado_devolvido) 
			 AND   ( @p_dt_inicio_vigencia IS NULL OR dt_inicio_vigencia = @p_dt_inicio_vigencia) 
			 AND   ( @p_dt_fim_vigencia IS NULL OR dt_fim_vigencia = @p_dt_fim_vigencia) 
			 AND   ( @p_gerar_etiqueta_comprador IS NULL OR gerar_etiqueta_comprador = @p_gerar_etiqueta_comprador) 
			 AND   ( @p_gerar_etiqueta_proprietario IS NULL OR gerar_etiqueta_proprietario = @p_gerar_etiqueta_proprietario) 
			 AND   ( @p_id_atividade_transferencia IS NULL OR id_atividade_transferencia = @p_id_atividade_transferencia) 

		;WITH TablePage AS(

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

				,ROW_NUMBER() OVER(ORDER BY		

								CASE WHEN @p_order_by = 'id_atividade_transferencia' AND @p_order_by_direction = 'A' THEN id_atividade_transferencia END ASC,
								CASE WHEN @p_order_by = 'id_atividade_transferencia' AND @p_order_by_direction = 'D' THEN id_atividade_transferencia END DESC,
								CASE WHEN @p_order_by = 'id_atividade' AND @p_order_by_direction = 'A' THEN id_atividade END ASC,
								CASE WHEN @p_order_by = 'id_atividade' AND @p_order_by_direction = 'D' THEN id_atividade END DESC,
								CASE WHEN @p_order_by = 'dt_solicitacao' AND @p_order_by_direction = 'A' THEN dt_solicitacao END ASC,
								CASE WHEN @p_order_by = 'dt_solicitacao' AND @p_order_by_direction = 'D' THEN dt_solicitacao END DESC,
								CASE WHEN @p_order_by = 'id_animal' AND @p_order_by_direction = 'A' THEN id_animal END ASC,
								CASE WHEN @p_order_by = 'id_animal' AND @p_order_by_direction = 'D' THEN id_animal END DESC,
								CASE WHEN @p_order_by = 'id_proprietario' AND @p_order_by_direction = 'A' THEN id_proprietario END ASC,
								CASE WHEN @p_order_by = 'id_proprietario' AND @p_order_by_direction = 'D' THEN id_proprietario END DESC,
								CASE WHEN @p_order_by = 'id_comprador' AND @p_order_by_direction = 'A' THEN id_comprador END ASC,
								CASE WHEN @p_order_by = 'id_comprador' AND @p_order_by_direction = 'D' THEN id_comprador END DESC,
								CASE WHEN @p_order_by = 'prioritario' AND @p_order_by_direction = 'A' THEN prioritario END ASC,
								CASE WHEN @p_order_by = 'prioritario' AND @p_order_by_direction = 'D' THEN prioritario END DESC,
								CASE WHEN @p_order_by = 'certificado_devolvido' AND @p_order_by_direction = 'A' THEN certificado_devolvido END ASC,
								CASE WHEN @p_order_by = 'certificado_devolvido' AND @p_order_by_direction = 'D' THEN certificado_devolvido END DESC,
								CASE WHEN @p_order_by = 'dt_inicio_vigencia' AND @p_order_by_direction = 'A' THEN dt_inicio_vigencia END ASC,
								CASE WHEN @p_order_by = 'dt_inicio_vigencia' AND @p_order_by_direction = 'D' THEN dt_inicio_vigencia END DESC,
								CASE WHEN @p_order_by = 'dt_fim_vigencia' AND @p_order_by_direction = 'A' THEN dt_fim_vigencia END ASC,
								CASE WHEN @p_order_by = 'dt_fim_vigencia' AND @p_order_by_direction = 'D' THEN dt_fim_vigencia END DESC,
								CASE WHEN @p_order_by = 'gerar_etiqueta_comprador' AND @p_order_by_direction = 'A' THEN gerar_etiqueta_comprador END ASC,
								CASE WHEN @p_order_by = 'gerar_etiqueta_comprador' AND @p_order_by_direction = 'D' THEN gerar_etiqueta_comprador END DESC,
								CASE WHEN @p_order_by = 'gerar_etiqueta_proprietario' AND @p_order_by_direction = 'A' THEN gerar_etiqueta_proprietario END ASC,
								CASE WHEN @p_order_by = 'gerar_etiqueta_proprietario' AND @p_order_by_direction = 'D' THEN gerar_etiqueta_proprietario END DESC,
								CASE WHEN @p_order_by = 'id_usuario_inclusao' AND @p_order_by_direction = 'A' THEN id_usuario_inclusao END ASC,
								CASE WHEN @p_order_by = 'id_usuario_inclusao' AND @p_order_by_direction = 'D' THEN id_usuario_inclusao END DESC,
								CASE WHEN @p_order_by = 'dt_alteracao' AND @p_order_by_direction = 'A' THEN dt_alteracao END ASC,
								CASE WHEN @p_order_by = 'dt_alteracao' AND @p_order_by_direction = 'D' THEN dt_alteracao END DESC,
								CASE WHEN @p_order_by = 'id_usuario_alteracao' AND @p_order_by_direction = 'A' THEN id_usuario_alteracao END ASC,
								CASE WHEN @p_order_by = 'id_usuario_alteracao' AND @p_order_by_direction = 'D' THEN id_usuario_alteracao END DESC
								) as intRow			

			FROM	stb.tbAtividadeTransferencia (nolock)
			WHERE 
				  ( @p_id_atividade_transferencia IS NULL OR id_atividade_transferencia = @p_id_atividade_transferencia) 
			 AND   ( @p_id_atividade IS NULL OR id_atividade = @p_id_atividade) 
			 AND   ( @p_dt_solicitacao IS NULL OR dt_solicitacao = @p_dt_solicitacao) 
			 AND   ( @p_id_animal IS NULL OR id_animal = @p_id_animal) 
			 AND   ( @p_id_proprietario IS NULL OR id_proprietario = @p_id_proprietario) 
			 AND   ( @p_id_comprador IS NULL OR id_comprador = @p_id_comprador) 
			 AND   ( @p_prioritario IS NULL OR prioritario = @p_prioritario) 
			 AND   ( @p_certificado_devolvido IS NULL OR certificado_devolvido = @p_certificado_devolvido) 
			 AND   ( @p_dt_inicio_vigencia IS NULL OR dt_inicio_vigencia = @p_dt_inicio_vigencia) 
			 AND   ( @p_dt_fim_vigencia IS NULL OR dt_fim_vigencia = @p_dt_fim_vigencia) 
			 AND   ( @p_gerar_etiqueta_comprador IS NULL OR gerar_etiqueta_comprador = @p_gerar_etiqueta_comprador) 
			 AND   ( @p_gerar_etiqueta_proprietario IS NULL OR gerar_etiqueta_proprietario = @p_gerar_etiqueta_proprietario) 
			 AND   ( @p_id_atividade_transferencia IS NULL OR id_atividade_transferencia = @p_id_atividade_transferencia) 

		)	



	--QUERY RESULT

	SELECT 
		* 
	FROM 
		TablePage
	WHERE 
		@intStartRow IS NULL 
		OR (intRow BETWEEN @intStartRow AND @intEndRow)	
	END TRY

	BEGIN CATCH
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
