#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):134217728:f74cbb3a0da018c0c6e5e27d6b94178bf187b6d9; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:80dd9b44a2a28e7c3802435240820f8823ff6ce5 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):134217728:f74cbb3a0da018c0c6e5e27d6b94178bf187b6d9 && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
