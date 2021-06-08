sub ShowSpellList {
  #class = 0, level = 1, stat = 2
  #my $character_classInsert = $_[0];
  #  my $character_class = $class;
  #  my $class = $_[0];
  my $class = $_[0];
  #$class = necromancer;
  #my $OrderBy = $_[2];
  #my $QueryLimit = 1000;
	
  $connect = plugin::LoadMysql();

  $query = "SELECT
    `Name`,
    `class`,
    `level`,
    `expansion`,
    `spell_id`
      FROM
    `va_spells`
      WHERE class = ? ORDER BY level";
  $query_handle = $connect->prepare($query);

  ###  $query_handle->execute($class);
  $query_handle->execute(
    $class
  );
  quest::debug("$DBI::errstr") if $DBI::errstr;
  my $Result = "";
  while (@row = $query_handle->fetchrow_array()){
  #my ($spell_name, $spell_class, $spell_level, $spell_expansion, $spell_id) = $query_handle->fetchrow();
  #quest::debug("Name: $spell_name");
  #quest::debug("Class $spell_class");
  #quest::debug("Level $spell_level");
  #quest::debug("Expansion $spell_expansion");
  #quest::debug("ID $spell_id");

  #  my $Result = "";
  while (@row = $query_handle->fetchrow_array()){
    my $spell_name = $row[0];
    my $spell_class = $row[1];
    my $spell_level = $row[2];
    my $spell_expansion = $row[3];
    my $spell_id = $row[4];
    quest::debug("ID $spell_id");
    $count++;
	
  $Result .= "
    <tr>
      <td><c \"#FFFF66\">$count~</td>
      <td><c \"#FFFF66\">" . $spell_name . "~</td>
      <td><c \"#DF7401\">" . $spell_class . "~ </td>
      <td><c \"#00FF00\">" . $spell_level . "~ </td>
      <td><c \"#FF0000\">" . $spell_expansion . "~ </td>
      <td><c \"#3366FF\">" . $spell_id . "~ </td>
    </tr>";
  }

  $count = 0;
  plugin::DiaWind(
    "
    {linebreak}
    <br>
    Spells ~
    <br>
    {linebreak}
    <br>
    <table>
      <tr>
        <th></th>
        <th>Name</th>
        <th>Class</th>
        <th>Level</th>
        <th>Expansion</th>
        <th>Spell ID</th>
      </tr>
      " . $Result . "
    </table>
  ");
}
