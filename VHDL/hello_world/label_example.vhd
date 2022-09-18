rom: BLOCK
port(direccion: in bit_vector(15 downto 0);
    enable: in bit;
    dato: out bit_vector(7 downto 0));
    PORT MAP(direccion=>rom_dir, enable=>rom_ena, dato=>rom_dato);
begin
    ...
end BLOCK rom;
