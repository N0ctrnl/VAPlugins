sub ShowSpellList {
  my $class = $_[0];
  my $levelrange = $_[1];
  my $client = plugin::val('$client');

  if($levelrange eq "low"){
    $level_low = 1;
    $level_high = 20;
  } elsif($levelrange eq "medium"){
    $level_low = 21;
    $level_high = 40;
  } elsif($levelrange eq "high"){
    $level_low = 41;
    $level_high = 60;
  } elsif($levelrange eq "max"){
    $level_low = 61;
    $level_high = 65;
  } elsif($levelrange eq "all"){
    $level_low = 1;
    $level_high = 65;
  }

  $connect = plugin::LoadMysql();
  $query = "SELECT
    `Name`,
    `level`,
    `expansion`
      FROM
    `va_spells2`
      WHERE class = ? AND level >= ? and level <= ? ORDER BY level ASC";

  $query_handle = $connect->prepare($query);
  $query_handle->execute($class,$level_low,$level_high);

  while (@row = $query_handle->fetchrow_array()){
    my ($spell_name, $spell_level, $spell_expansion) = $query_handle->fetchrow();
    $client->Message(315, $spell_name . " - " . $spell_level . " - " . $spell_expansion);
  }
}
