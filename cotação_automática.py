import requests
from bs4 import BeautifulSoup
import pandas as pd
from datetime import datetime
import os

def obter_preco_produto(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  
    except requests.RequestException as e:
        print(f"Erro ao acessar a página: {e} para URL: {url}")
        return None
    
    soup = BeautifulSoup(response.text, 'html.parser')
    
    preco_inteiro_elemento = soup.find('span', {'class': 'a-price-whole'})
    if preco_inteiro_elemento:
        preco_inteiro = preco_inteiro_elemento.get_text(strip=True)
    else:
        print(f"Preço não encontrado para o produto: {url}")
        return None
    
    preco_decimal_elemento = soup.find('span', {'class': 'a-price-decimal'})
    preco_decimal = preco_decimal_elemento.get_text(strip=True) if preco_decimal_elemento else ''
    
    preco_completo = preco_inteiro + preco_decimal
    
    try:
        preco = float(preco_completo.replace(',', '.'))
        return preco
    except ValueError:
        print(f"Erro ao converter o preço para float: {preco_completo} para URL: {url}")
        return None

def salvar_em_excel(dados, arquivo='precos_amazon.xlsx'):
    if os.path.exists(arquivo):
        print(f"Arquivo {arquivo} já existe. Sobrescrevendo...")
    
    df = pd.DataFrame(dados, columns=['Link do Produto', 'Preço', 'Data da Cotação'])
    df.to_excel(arquivo, index=False)

links_produtos = [
    "https://www.amazon.com.br/Mouse-Redragon-Chroma-12400DPI-Bot%C3%B5es/dp/B07Q437WXK/ref=pd_bxgy_d_sccl_1/144-8456024-2410658?psc=1",
    "https://www.amazon.com.br/Ideias-T%C3%AAm-Consequ%C3%AAncias-Richard-Weaver/dp/8580332648/ref=sr_1_1?sr=8-1&ufe=app_do%3Aamzn1.fos.6d798eae-cadf-45de-946a-f477d47705b9",
]

dados = []

for url in links_produtos:
    preco = obter_preco_produto(url)
    if preco:
        dados.append((url, preco, datetime.now().strftime("%Y-%m-%d %H:%M:%S")))

if dados:
    salvar_em_excel(dados)
    print("Dados salvos com sucesso em 'precos_amazon.xlsx'")
else:
    print("Nenhum dado foi extraído.")
