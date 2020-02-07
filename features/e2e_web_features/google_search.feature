Feature: Busqueda de personas en Google

  @web_tests
  Scenario: El robot busca a nuestros usuarios en Google
    Given El usuario "Zulema Santacruz" es un usuario registrado
    When El robot accede a Goole
    And se busca al usuario por nickname
    Then el primer resultado de la búsqueda es accesado


  @web_tests
  Scenario Outline: El robot busca a todos nuestros usuarios en Google
    Given El usuario "<user_name>" es un usuario registrado
    When El robot accede a Goole
    And se busca al usuario por nickname
    Then el primer resultado de la búsqueda es accesado
    Examples:
      | user_name        |
      | Zulema Santacruz |
      | Kei Takayama     |
      | Misael Castillo  |

