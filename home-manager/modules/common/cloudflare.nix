{
  pkgs,
  config,
  tunnelId,
  tunnelName,
  ...
}:

{
  home.packages = with pkgs; [
    cloudflared
  ];

  # Cloudflare Tunnel
  home.file.".cloudflared/config.yml".text = ''
    tunnel: ${tunnelId}
    credentials-file: ${config.home.homeDirectory}/.cloudflared/${tunnelId}.json
    warp-routing:
      enabled: true
  '';

  systemd.user.services.cloudflared = {
    Unit.Description = "Cloudflare Tunnel";
    Service = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
      Restart = "always";
    };
    Install.WantedBy = [ "default.target" ];
  };

}
