library IEEE;
use IEEE.std_logic_1164.all;

entity Shift_Register_tb is
end entity;

architecture behavior of Shift_Register_tb is

  -- Deklarasi komponen UUT
  component Shift_Register
    port (
      Clock, Reset : in std_logic;
      Din          : in std_logic_vector(7 downto 0);
      Dout0, Dout1 : out std_logic_vector(7 downto 0);
      Dout2, Dout3 : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Sinyal penghubung ke UUT
  signal Clock : std_logic := '0';
  signal Reset : std_logic := '1';
  signal Din   : std_logic_vector(7 downto 0) := (others => '0');
  signal Dout0, Dout1, Dout2, Dout3 : std_logic_vector(7 downto 0);

  constant clk_period : time := 10 ns;

begin

  -- Instansiasi UUT
  uut: Shift_Register
    port map (
      Clock => Clock,
      Reset => Reset,
      Din   => Din,
      Dout0 => Dout0,
      Dout1 => Dout1,
      Dout2 => Dout2,
      Dout3 => Dout3
    );

  -- Clock Generator
  clk_process : process
  begin
    while true loop
      Clock <= '0';
      wait for clk_period / 2;
      Clock <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

  -- Proses stimulasi
  stim_proc : process
  begin
    -- Reset aktif (0)
    Reset <= '0';
    wait for 15 ns;
    Reset <= '1';

    -- Masukkan data secara berurutan
    wait for clk_period;
    Din <= x"11";
    wait for clk_period;
    Din <= x"22";
    wait for clk_period;
    Din <= x"33";
    wait for clk_period;
    Din <= x"44";
    wait for clk_period;
    Din <= x"55";
    wait for clk_period;

    -- Akhiri simulasi
    wait;
  end process;

end architecture;
