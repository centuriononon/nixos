{ pkgs, ... }:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  environment.etc."codex/config.toml".source = tomlFormat.generate "codex-system-config" {
    personality = "pragmatic";
    model = "gpt-5.6-sol";
    model_reasoning_effort = "high";
    service_tier = "default";
    default_permissions = ":read-only";
    approval_policy = "on-request";

    mcp_servers.openaiDeveloperDocs.url = "https://developers.openai.com/mcp";

    tui = {
      notifications = [ "approval-requested" ];
      notification_condition = "unfocused";
      notification_method = "osc9";
    };
  };
}
