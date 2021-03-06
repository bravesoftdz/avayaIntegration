unit uCtConector;

interface

uses uRoutingServicesCtConector;

type
  // CLASSE UTILIZADA PARA CONEXAO COM O PABX AVAYA.
  // ESTA CLASSE EH DESCENDENTE DE TODA HIERARQUIA QUE IMPLEMENTA A COMUNICACAO
  // COM O PABX, DEVENDO SER UTILIZADA DIRETAMENTE EM QUALQUER IMPLEMENTACAO.

  // TODA SOLICITACAO AO PABX DEVE SER FEITA ATRAVES DAS FUNCOES EXISTENTES NESTA
  // CLASSE, SENDO QUE SEUS RETORNOS N�O SIGNIFICAM QUE A SOLICITACAO FOI ATENDIDA,
  // MAS QUE ELA FOI ENVIADA AO PABX.
  // O CODIGO INTEIRO RETORNADO PELAS FUNCIOES �, NA VERDADE, O INVOKEID DA
  // SOLICITACAO QUE DEVE SER 'CASADO' COM O INVOKEID DA CONFIRMACAO EM QUESTAO.

  // POR EXEMPLO:

  // QUANDO FOR NECESSARIO REALIZAR UMA CHAMADA PREDITIVA (MAKEPREDICTIVECALL),
  // A UTILIZACAO DEVE SER A SEGUINTE:

  // PRIMEIRAMENTE DEVE SER IMPLEMENTADO O TRATADOR DE EVENTO DE CONFIRMACAO
  // PARA O MAKEPREDICTIVECALL, COM PROTOTYPE DEFINIDO EM uCtEvents:

  {
  procedure MinhaClasse.DoOnMakePredictiveCallConf( Sender : TObject;
    InvokeID : TInvokeID; newCall : ConnectionID_t; ucid : ATTUCID_t );
  begin
  // NESTE EVENTO TENHO TUDO QUE EU PRECISO:
    // - INVOKEID QUE SERA BATIDO COM O OBTIDO NA CHAMADA DO METODO
    //MakePredictiveCall;
    // - CALLID DA NOVA CHAMADA EM newCall.callId.

  // A PARTIR DO INSTANTE QUE RECEBI ESTA CONFIRMACAO, TENHO CERTEZA QUE O
  // PABX EST� EFETIVAMENTE PROCESSANDO MINHA REQUISICAO.
  // OUTRAS FUNCIONALIDADES (QUE NAO O MAKEPREDICTIVECALL) FUNCIONAM DE FORMA
  // AN�LOGA.
  end;
   }

  // EM SEGUIDA PODE SER IMPLEMENTADA A CHAMADA DO METODO:

  {
  var
    ctResult : Integer
  begin
    ctResult := Objeto.MakePredictiveCall(Parametros);
    if ctResult >= 0 then
      begin
      // SOLICITACAO FEITA COM SUCESSO
      // GUARDAR O VALOR DE ctResult PARA QUE ELE SEJA BATIDO COM A CONFIRMACAO
      // NO EVENTO OnCSTAMakePredictiveCallConf OU ATE MESMO AS TRANSICOES DE UMA
      // MAQUINA DE ESTADOS QUE AGUARDAR� A CONFIRMACAO.
      end
    else
      begin
      // ERRO NA SOLICITACAO. A UNIT uTranslations PODE SER UTILIZADA PARA MELHOR
      // DESCRICAO DO ERRO.
      ShowMessage( Format( 'Erro em MakePredictiveCall: %s',
        [ CtReturnToStr( ctResult ) ] );
      end;
  end;
  }

  TCtConector = class( TRoutingServicesCtConector );

implementation

end.
 