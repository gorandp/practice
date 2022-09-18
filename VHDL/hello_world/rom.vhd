ENTITY rom is
    GENERIC(tamano, ancho: positive);
    PORT(enable: IN bit;
        address: IN bit_vector(tamano-1 DOWNTO 0);
        data: OUT bit_vector(ancho-1 DOWNTO 0)
        );
END rom;
