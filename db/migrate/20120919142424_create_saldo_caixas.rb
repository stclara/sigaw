class CreateSaldoCaixas < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE TYPE saldo_caixa AS ( 
        saldo_anterior numeric(18,2),
        debito numeric(18,2),
        credito numeric(18,2),
        saldo numeric(18,2),
        inicio date,
        fim date 
      );
    SQL
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE OR REPLACE FUNCTION saldocaixa(date, date) RETURNS SETOF saldo_caixa AS
      $body$
      DECLARE
        debito_ant NUMERIC(18,2);
        credito_ant NUMERIC(18,2);
        debito_atual NUMERIC(18,2);
        credito_atual NUMERIC(18,2);
        linha saldo_caixa;

      begin
        linha.saldo_anterior := 0;
        linha.debito := 0;
        linha.credito := 0;
        linha.saldo := 0;

        SELECT INTO debito_atual SUM(value_cash) FROM cashes WHERE (type_cash= 'D' and date_cash between $1 and $2);
        SELECT INTO credito_atual SUM(value_cash) FROM cashes WHERE (type_cash= 'C' and date_cash between $1 and $2);
        SELECT INTO credito_ant SUM(value_cash) FROM cashes WHERE (type_cash= 'C' and date_cash < $1 );
        SELECT INTO debito_ant SUM(value_cash) FROM cashes WHERE (type_cash= 'D' and date_cash < $1 );

        if credito_atual is null then credito_atual = 0; end if;
        if debito_atual is null then debito_atual = 0; end if;
        if credito_ant is null then credito_ant = 0; end if;
        if debito_ant is null then debito_ant = 0; end if;
  
        linha.saldo_anterior = (credito_ant - debito_ant);
        linha.debito = debito_atual;
        linha.credito = credito_atual;
        linha.saldo = linha.saldo_anterior + (credito_atual - debito_atual);
        linha.inicio = $1;
        linha.fim = $2;
        return next linha;
      RETURN;
      END
      $body$
      LANGUAGE 'plpgsql';
      SQL
      
  end
end
