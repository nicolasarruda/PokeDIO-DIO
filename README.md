# PokeDIO

PokeDIO é um contrato inteligente (smart contract) baseado na blockchain do Ethereum.
Esse contrato permite a criação e batalha de Pokémons como tokens não fungíveis (NFTs), utilizando o padrão ERC721.

## Funcionalidades

- **Criação de Pokémons**: Apenas o proprietário do contrato pode criar novos Pokémons,
  que são NFTs.
- **Batalhas entre Pokémons**: Os usuários podem batalhar com seus Pokémons. O resultado
  da batalha altera os níveis dos Pokémons envolvidos.

## Estrutura do Código

### Contrato: `PokeDIO`

O contrato `PokeDIO` é uma implementação do padrão ERC721, permitindo a criação
e gerenciamento de Pokémons como NFTs.

#### Estruturas

- `Pokemon`: Uma estrutura (struct) que contém informações sobre cada Pokémon,
  incluindo seu nome (name), nível(level) e imagem(img).

#### Funções Principais

- `createNewPokemon(string memory _name, address _to, string memory _img)`: Cria um novo Pokémon e o mint (criação de novos tokens ou ativos digitais) para o endereço especificado.
- `battle(uint _attackingPokemon, uint _defendingPokemon)`: Permite que um Pokémon
  ataque outro, alterando seus níveis com base no resultado da batalha.

### Modificadores

- `onlyOwnerOf(uint _monsterId)`: Restringe o acesso a funções de batalha apenas
  ao proprietário do Pokémon.
