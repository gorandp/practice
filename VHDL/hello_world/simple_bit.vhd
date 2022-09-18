ENTITY simple_bit is
    port(a,b: in bit_vector(10 downto 0);
        amayb,aeqb,amenb: out bit);
END simple_bit;

architecture flujo of simple_bit is
    begin
        amayb <= '1' when a>b else '0';
        aeqb <= '1' when a=b else '0';
        amenb <= '1' when a<b else '0';
begin

end flujo ; -- flujo
