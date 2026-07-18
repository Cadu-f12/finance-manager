from decimal import Decimal

def main():
    SALDO_ATUAL = Decimal("1637.80")

    DESPESAS_FIXAS = {
        "conta_da_internet":Decimal("59.95"),
        "academia":Decimal("149.99"),
        "plano_vivo":Decimal("41"),
        "alimentacao":Decimal("125.00"),
    }

    DESPESAS_VARIAVEIS = {
        "cartao_estudante":Decimal("136.40"),
        "agua_e_luz":Decimal("150.00"),
        "fatura_cartao":Decimal("33.22"),
        "corte_de_cabelo":Decimal("50"),
        "produtos_hiegene":Decimal("0"),
    }

    PESO_INVESTIMENTOS = {
        "porquinho":Decimal("0.5"),
        "cdb":Decimal("0.25"),
        "lci_lca":Decimal("0.25"),
        "fiis":Decimal("0"),
    }

    PESO_LIQUIDO = {
        "investimento":Decimal("0.65"), 
        "lazer":Decimal("0.35")
    }

    total_despesas_fixas = Decimal("0")
    total_despesas_var = Decimal("0")

    for despesa in DESPESAS_FIXAS.keys():
        total_despesas_fixas += DESPESAS_FIXAS.get(despesa)

    for despesa in DESPESAS_VARIAVEIS.keys():
        total_despesas_var += DESPESAS_VARIAVEIS.get(despesa)

    total_despesas = total_despesas_fixas + total_despesas_var

    saldo_liquido = SALDO_ATUAL - total_despesas

    total_investimento = PESO_LIQUIDO.get("investimento") * saldo_liquido
    total_lazer = PESO_LIQUIDO.get("lazer") * saldo_liquido

    lazer_alimentacao = total_lazer + DESPESAS_FIXAS.get("alimentacao")

    investimentos = {
        "CDB_PORQUINHO": PESO_INVESTIMENTOS.get("porquinho") * total_investimento,
        "CDB_LIQUIDEZ_DIARIA": PESO_INVESTIMENTOS.get("cdb") * total_investimento,
        "LCI_LCA": PESO_INVESTIMENTOS.get("lci_lca") * total_investimento,
        "FIIS": PESO_INVESTIMENTOS.get("fiis") * total_investimento,
    }

    print(
        f"SALDO ATUAL: {round(SALDO_ATUAL, 2)}" + "\n"
        f"TOTAL DE DESPESAS FIXAS: {round(total_despesas_fixas, 2)}" + "\n"
        f"TOTAL DE DEPESAS VÁRIAVEIS: {round(total_despesas_var, 2)}" + "\n"
        f"TOTAL DE DESPESAS DO MÊS: {round(total_despesas, 2)}" + "\n"
        f"SALDO LIQUIDO: {round(saldo_liquido, 2)}" + "\n"
        f"QUANTIDADE PARA INVESTIR: {round(total_investimento, 2)}" + "\n"
        f"QUANTIDADE PARA GASTAR: {round(total_lazer, 2)}" + "\n"
        f"LAZER MAIS ALIMENTAÇÃO: {round(lazer_alimentacao, 2)}" + "\n"
    )

    for key in investimentos.keys():
        print(f"INVESTIR EM {key}: {round(investimentos.get(key), 2)}")

if __name__ == "__main__":
    main()
