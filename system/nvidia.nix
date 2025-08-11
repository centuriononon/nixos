{
  pkgs,
  config,
  ...
}:
let
  # Using beta driver for recent GPUs like RTX 4070
  nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  services.xserver.videoDrivers = [ "nvidia" ];

  # Blacklist nouveau to avoid conflicts
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Environment variables for better compatibility
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia"; # Hardware video acceleration
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Use Nvidia driver for GLX
    __GL_GSYNC_ALLOWED = "1"; # Enable G-Sync if available
    __GL_VRR_ALLOWED = "1"; # Enable VRR (Variable Refresh Rate)
  };

  # Configuration for proprietary packages
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    allowUnfree = true;
  };

  # Nvidia configuration
  hardware = {
    nvidia = {
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
      modesetting.enable = true;
      package = nvidiaDriverChannel;
      forceFullCompositionPipeline = true;
    };
  };

  # Nix cache for CUDA
  nix.settings = {
    substituters = [ "https://cuda-maintainers.cachix.org" ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  # Additional useful packages
  environment.systemPackages = with pkgs; [
    vulkan-tools
    glxinfo
    libva-utils # VA-API debugging tools
  ];
}
