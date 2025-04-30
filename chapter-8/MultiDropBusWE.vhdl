library IEEE;
use IEEE.std_logic_1164.all;

entity MultiDropBusWE is
  port (
    Clock     : in  std_logic;
    Reset     : in  std_logic;
    A_EN      : in  std_logic;
    B_EN      : in  std_logic;
    C_EN      : in  std_logic;
    A_WE      : in  std_logic;
    B_WE      : in  std_logic;
    C_WE      : in  std_logic;
    Data_Bus  : inout std_logic_vector(7 downto 0);
    A, B, C   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture MultiDropBus_arch of MultiDropBusWE is

  signal reg_A, reg_B, reg_C : std_logic_vector(7 downto 0);
  signal Data_Bus_internal   : std_logic_vector(7 downto 0);

begin

  -- Register A
  process (Clock, Reset)
  begin
    if Reset = '0' then
      reg_A <= (others => '0');
    elsif rising_edge(Clock) then
      if A_EN = '1' then
        reg_A <= Data_Bus;
      end if;
    end if;
  end process;

  -- Register B
  process (Clock, Reset)
  begin
    if Reset = '0' then
      reg_B <= (others => '0');
    elsif rising_edge(Clock) then
      if B_EN = '1' then
        reg_B <= Data_Bus;
      end if;
    end if;
  end process;

  -- Register C
  process (Clock, Reset)
  begin
    if Reset = '0' then
      reg_C <= (others => '0');
    elsif rising_edge(Clock) then
      if C_EN = '1' then
        reg_C <= Data_Bus;
      end if;
    end if;
  end process;

  -- Output register ke luar
  A <= reg_A;
  B <= reg_B;
  C <= reg_C;

  -- Logika tristate ke internal bus
  Data_Bus_internal <= reg_A when A_WE = '1' else
                       reg_B when B_WE = '1' else
                       reg_C when C_WE = '1' else
                       (others => 'Z');

  -- Mapping internal bus ke port inout
  Data_Bus <= Data_Bus_internal;

end architecture;
