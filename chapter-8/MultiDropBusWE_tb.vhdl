library IEEE;
use IEEE.std_logic_1164.all;

entity MultiDropBusWE_tb is
end entity;

architecture behavior of MultiDropBusWE_tb is

  -- Komponen yang diuji (UUT)
  component MultiDropBusWE
    port (
      Clock, Reset     : in std_logic;
      A_EN, B_EN, C_EN : in std_logic;
      A_WE, B_WE, C_WE : in std_logic;
      Data_Bus         : inout std_logic_vector(7 downto 0);
      A, B, C          : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Sinyal uji
  signal Clock   : std_logic := '0';
  signal Reset   : std_logic := '1';
  signal Data_Bus : std_logic_vector(7 downto 0) := (others => '0');
  signal A_EN, B_EN, C_EN : std_logic := '0';
  signal A_WE, B_WE, C_WE : std_logic := '0';
  signal A, B, C : std_logic_vector(7 downto 0);

  constant clk_period : time := 10 ns;

begin

  -- Instansiasi UUT
  uut: MultiDropBusWE
    port map (
      Clock   => Clock,
      Reset   => Reset,
      Data_Bus => Data_Bus,
      A_EN    => A_EN,
      B_EN    => B_EN,
      C_EN    => C_EN,
      A_WE    => A_WE,
      B_WE    => B_WE,
      C_WE    => C_WE,
      A       => A,
      B       => B,
      C       => C
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

  -- Stimulus Process
  stim_proc : process
  begin
    -- Reset
    Reset <= '0';
    wait for 10 ns;
    Reset <= '1';

    wait for clk_period;

    -------------------------------------
    -- Simulasi: Register A menulis ke bus, B membaca
    -------------------------------------
    -- Set isi register A ke x"AA"
    A_EN <= '1';
    Data_Bus <= x"AA";  -- simulate data being placed on bus
    wait for clk_period;
    A_EN <= '0';

    -- A tulis ke bus, B baca dari bus
    A_WE <= '1';
    B_EN <= '1';
    wait for clk_period;
    A_WE <= '0';
    B_EN <= '0';

    -------------------------------------
    -- Simulasi: Register C menulis ke bus, A membaca
    -------------------------------------
    -- Set isi register C ke x"CC"
    C_EN <= '1';
    Data_Bus <= x"CC";
    wait for clk_period;
    C_EN <= '0';

    -- C tulis ke bus, A baca
    C_WE <= '1';
    A_EN <= '1';
    wait for clk_period;
    C_WE <= '0';
    A_EN <= '0';

    -- Akhir simulasi
    wait for 20 ns;
    wait;
  end process;
  
end architecture;
