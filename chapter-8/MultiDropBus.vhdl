LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MultiDropBus is
  port (
    Clock, Reset : in std_logic;
    Data_Bus     : in std_logic_vector(7 downto 0);
    A_EN, B_EN, C_EN : in std_logic;
    A, B, C      : out std_logic_vector(7 downto 0)
  );
end entity;

architecture MultiDropBus_arch of MultiDropBus is
begin
  A_REG : process (Clock, Reset)
  begin
    if (Reset = '0') then
      A <= x"00";
    elsif (Clock'event and Clock='1') then
      if (A_EN = '1') then
        A <= Data_Bus;
      end if;
    end if;
  end process;
  
  B_REG : process (Clock, Reset)
  begin
    if (Reset = '0') then
      B <= x"00";
    elsif (Clock'event and Clock='1') then
      if (B_EN = '1') then
        B <= Data_Bus;
      end if;
    end if;
  end process;

  C_REG : process (Clock, Reset)
  begin
    if (Reset = '0') then
      C <= x"00";
    elsif (Clock'event and Clock='1') then
      if (C_EN = '1') then
        C <= Data_Bus;
      end if;
    end if;
  end process;

end architecture;
