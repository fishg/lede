# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020 OpenWrt.org

define KernelPackage/drm-rockchip
  SUBMENU:=$(VIDEO_MENU)
  TITLE:=Rockchip DRM support
  DEPENDS:=@TARGET_rockchip +kmod-backlight +kmod-drm-kms-helper \
	+kmod-multimedia-input +LINUX_6_1:kmod-drm-display-helper +LINUX_6_1:kmod-gpu-lima
  KCONFIG:= \
	CONFIG_DRM_ROCKCHIP \
	CONFIG_DRM_LOAD_EDID_FIRMWARE=y \
	CONFIG_DRM_FBDEV_EMULATION=y \
	CONFIG_DRM_FBDEV_OVERALLOC=100 \
	CONFIG_DRM_BRIDGE=y \
	CONFIG_HDMI=y \
	CONFIG_PHY_ROCKCHIP_INNO_HDMI \
	CONFIG_DRM_DW_HDMI \
	CONFIG_DRM_DW_HDMI_CEC \
	CONFIG_ROCKCHIP_ANALOGIX_DP=n \
	CONFIG_ROCKCHIP_CDN_DP=n \
	CONFIG_ROCKCHIP_DW_HDMI=y \
	CONFIG_ROCKCHIP_DW_MIPI_DSI=y \
	CONFIG_ROCKCHIP_INNO_HDMI=y \
	CONFIG_ROCKCHIP_LVDS=y \
	CONFIG_ROCKCHIP_RGB=n \
	CONFIG_ROCKCHIP_RK3066_HDMI=n \
	CONFIG_ROCKCHIP_VOP=y \
	CONFIG_ROCKCHIP_VOP2=y \
	CONFIG_DRM_GEM_CMA_HELPER@lt6.1 \
	CONFIG_DRM_GEM_DMA_HELPER@ge6.1 \
	CONFIG_DRM_PANEL=y \
	CONFIG_DRM_PANEL_BRIDGE=y \
	CONFIG_DRM_PANEL_SIMPLE
  FILES:= \
	$(LINUX_DIR)/drivers/gpu/drm/bridge/synopsys/dw-hdmi.ko \
	$(LINUX_DIR)/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.ko \
	$(LINUX_DIR)/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.ko \
	$(LINUX_DIR)/drivers/phy/rockchip/phy-rockchip-inno-hdmi.ko \
	$(LINUX_DIR)/drivers/gpu/drm/drm_dp_aux_bus.ko@lt5.19 \
	$(LINUX_DIR)/drivers/gpu/drm/drm_dma_helper.ko@ge6.1 \
	$(LINUX_DIR)/drivers/gpu/drm/panel/panel-simple.ko \
	$(LINUX_DIR)/drivers/gpu/drm/rockchip/rockchipdrm.ko \
	$(LINUX_DIR)/drivers/media/cec/core/cec.ko
  AUTOLOAD:=$(call AutoProbe,rockchipdrm phy-rockchip-inno-hdmi dw-hdmi-cec)
endef

define KernelPackage/drm-rockchip/description
  Direct Rendering Manager (DRM) support for Rockchip
endef

$(eval $(call KernelPackage,drm-rockchip))

define KernelPackage/saradc-rockchip
  SUBMENU:=$(IIO_MENU)
  TITLE:=Rockchip SARADC support
  DEPENDS:=@TARGET_rockchip +kmod-industrialio-triggered-buffer
  KCONFIG:= \
	CONFIG_RESET_CONTROLLER=y \
	CONFIG_ROCKCHIP_SARADC
  FILES:= \
	$(LINUX_DIR)/drivers/iio/adc/rockchip_saradc.ko
  AUTOLOAD:=$(call AutoProbe,rockchip_saradc)
endef

define KernelPackage/saradc-rockchip/description
  Support for the SARADC found in SoCs from Rockchip
endef

$(eval $(call KernelPackage,saradc-rockchip))

define KernelPackage/gpu-lima
  SUBMENU:=$(VIDEO_MENU)
  TITLE:=Mali-4xx GPU support
  DEPENDS:=@TARGET_rockchip +kmod-drm
  KCONFIG:= \
	CONFIG_DRM_VGEM \
	CONFIG_DRM_GEM_CMA_HELPER=y \
	CONFIG_DRM_LIMA
  FILES:= \
	$(LINUX_DIR)/drivers/gpu/drm/vgem/vgem.ko \
	$(LINUX_DIR)/drivers/gpu/drm/drm_shmem_helper.ko \
	$(LINUX_DIR)/drivers/gpu/drm/scheduler/gpu-sched.ko \
	$(LINUX_DIR)/drivers/gpu/drm/lima/lima.ko
  AUTOLOAD:=$(call AutoProbe,lima vgem)
endef

define KernelPackage/gpu-lima/description
  Open-source reverse-engineered driver for Mali-4xx GPUs
endef

$(eval $(call KernelPackage,gpu-lima))

define KernelPackage/rockchip-vdec
  SUBMENU:=$(VIDEO_MENU)
  TITLE:=Rockchip Video Decoder driver
  DEPENDS:=@TARGET_rockchip +kmod-gpu-lima
  KCONFIG:= \
	CONFIG_MEDIA_SUPPORT=y \
	CONFIG_STAGING=y \
	CONFIG_STAGING_MEDIA=y \
	CONFIG_VIDEO_DEV=y \
	CONFIG_VIDEO_ROCKCHIP_VDEC
  FILES:= \
	$(LINUX_DIR)/drivers/staging/media/rkvdec/rockchip-vdec.ko \
	$(LINUX_DIR)/drivers/media/v4l2-core/v4l2-h264.ko \
	$(LINUX_DIR)/drivers/media/v4l2-core/v4l2-mem2mem.ko \
	$(LINUX_DIR)/drivers/media/v4l2-core/v4l2-vp9.ko \
	$(LINUX_DIR)/drivers/media/common/videobuf2/videobuf2-v4l2.ko \
	$(LINUX_DIR)/drivers/media/common/videobuf2/videobuf2-dma-contig.ko \
	$(LINUX_DIR)/drivers/media/common/videobuf2/videobuf2-common.ko \
	$(LINUX_DIR)/drivers/media/common/videobuf2/videobuf2-memops.ko
  AUTOLOAD:=$(call AutoProbe,vdec rkvdec)
endef

define KernelPackage/rockchip-vdec/description
  Open-source Rockchip Video Decoder driver
endef

$(eval $(call KernelPackage,rockchip-vdec))
