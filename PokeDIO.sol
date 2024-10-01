// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// Importa a implementação do padrão ERC721 da biblioteca OpenZeppelin, 
// Fornece funcionalidades para criar e gerenciar tokens não fungíveis (NFTs).
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// Contrato de gerenciamento de Pokemons.
// Cada Pokemon é representado como um token ERC721.
// Inclui funcionalidades de criação de Pokemons e batalhas entre eles.
contract PokeDIO is ERC721 {

    // Estrutura que armazena as informações de cada Pokemon
    struct Pokemon {
        string name; 
        uint level;   
        string img;   
    }

    // Array público que contém todos os Pokemons criados
    Pokemon[] public pokemons;

    // Endereço do dono do contrato, que tem permissão para criar novos Pokemons
    address public gameOwner;

    // Construtor que inicializa o contrato.
    // Define o dono e os parâmetros do ERC721
    constructor() ERC721("PokeDIO", "PKD") {
        gameOwner = msg.sender; 
    }

    // Modificador que restringe a batalha a apenas o dono do Pokémon correspondente.
    // Esse modificador verifica a propriedade do Pokémon antes de permitir a batalha.
    modifier onlyOwnerOf(uint _monsterId) {
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono pode batalhar com este Pokemon");
        _;
    }

    // Função que faz acontecer uma batalha entre dois pokemons.
    // O atacante e o defensor ganham níveis dependendo do resultado.
    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon) {
        Pokemon storage attacker = pokemons[_attackingPokemon];
        Pokemon storage defender = pokemons[_defendingPokemon];

        if (attacker.level >= defender.level) {
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level += 2;
        }
    }

    // Função que cria um novo pokemon ao dono. Somente o dono pode criar.
    // O novo pokemon é mintado e é atribuído a um endereço específico.
    function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Pokemons");
        uint id = pokemons.length;  
        pokemons.push(Pokemon(_name, 1, _img));  
        _safeMint(_to, id); 
    }
}
