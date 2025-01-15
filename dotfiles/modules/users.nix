{
  users = {
    mutableUsers = false;
    users.kstnbtw = {
      description = "knstntn";
      password = "asdasd";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      createHome = true;
      uid = 1000;
    };
  };
}
