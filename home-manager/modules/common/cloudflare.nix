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
    ingress:
      - hostname: ${tunnelName}.kazeusagi.dev
        service: ssh://localhost:22
      - service: http_status:404
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
