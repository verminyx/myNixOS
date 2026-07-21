{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        
   	input.keyboard.xkb = {
   	  layout = "us";
  	  variant = "altgr-intl";
	};

        layout.gaps = 5;

        binds = {
  	  "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
  	  "Mod+Q".close-window = {};
	  "Mod+F".maximize-column = {};
  	  "Mod+Shift+F".fullscreen-window = {};
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
	  #focus
	  "Mod+Left".focus-column-left = {};
  	  "Mod+Right".focus-column-right = {};
  	  "Mod+Down".focus-window-down = {};
  	  "Mod+Up".focus-window-up = {};
  	  "Mod+Home".focus-column-first = {};
  	  "Mod+End".focus-column-last = {};

	    # Window Movement
  	  "Mod+Shift+Left".move-column-left = {};
  	  "Mod+Shift+Right".move-column-right = {};
 	  "Mod+Shift+Down".move-window-down = {};
	  "Mod+Shift+Up".move-window-up = {};
	  "Mod+Shift+Home".move-column-to-first = {};
	  "Mod+Shift+End".move-column-to-last = {};
  
	  # Column Resizing
	  "Mod+Minus".set-column-width = "-10%";
	  "Mod+Equal".set-column-width = "+10%";
  
	  # Workspace Navigation
	  "Mod+1".focus-workspace = 1;
	  "Mod+2".focus-workspace = 2;
	  "Mod+3".focus-workspace = 3;
	  "Mod+4".focus-workspace = 4;
	  "Mod+5".focus-workspace = 5;
	  
	   # Window to Workspace
  	  "Mod+Shift+1".move-window-to-workspace = 1;
	  "Mod+Shift+2".move-window-to-workspace = 2;
	  "Mod+Shift+3".move-window-to-workspace = 3;
	  "Mod+Shift+4".move-window-to-workspace = 4;
	  "Mod+Shift+5".move-window-to-workspace = 5;
  
	  # Layout Control
	  "Mod+H".focus-column-left = {};
	  "Mod+J".focus-window-down = {};
	  "Mod+K".focus-window-up = {};
	  "Mod+L".focus-column-right = {};
	};
      };
    };
  };
}
