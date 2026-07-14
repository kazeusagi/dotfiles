{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    socat
  ];

  systemd.user.services.bitwarden-ssh-agent = {
    Unit = {
      Description = "Bridge Bitwarden Windows SSH Agent to WSL";
      ConditionPathExists = "/proc/sys/fs/binfmt_misc/WSLInterop";
    };
    Service = {
      ExecStart = ''
        ${pkgs.socat}/bin/socat \
          UNIX-LISTEN:%h/.bitwarden-ssh-agent.sock,fork,unlink-early,mode=600,unlink-close \
          EXEC:'/mnt/c/Users/T.Ito/AppData/Local/Microsoft/WinGet/Packages/albertony.npiperelay_Microsoft.Winget.Source_8wekyb3d8bbwe/npiperelay.exe -ei -s -p //./pipe/openssh-ssh-agent'
      '';
      Restart = "always";
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
  };
}
