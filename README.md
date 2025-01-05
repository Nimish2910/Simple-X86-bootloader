# Simple X86 Bootloader Emulation

## Overview

This project implements a simple x86 bootloader that displays the message "Hello, Bootloader World!" when executed. The bootloader is designed to run in an emulated environment using QEMU. It provides a foundational understanding of low-level programming, real-mode assembly, and how operating systems interact with hardware. This project has been developed and tested on macOS.

## Features

- Displays a custom message at boot time
- Demonstrates basic x86 assembly concepts
- Follows the BIOS boot process, loading at memory address `0x7C00`
- Compatible with QEMU for testing
- Fully tested on macOS

## Project Structure

- `bootloader.asm`: The main assembly file for the bootloader code
- `bootloader.bin`: The binary output of the assembled bootloader
- `bootloader.img`: The bootable disk image used by QEMU

## Prerequisites

This project requires macOS with the following tools installed:

1. **Homebrew**: Package manager for macOS
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **NASM**: For assembling the bootloader code
   ```bash
   brew install nasm
   ```

3. **QEMU**: For emulating the bootable disk image
   ```bash
   brew install qemu
   ```

4. **`dd` Command**: Pre-installed on macOS, used to create bootable disk images

## Building and Running

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/bootloader.git
   cd bootloader
   ```

2. **Assemble the Bootloader**
   ```bash
   nasm -f bin bootloader.asm -o bootloader.bin
   ```

3. **Create a Bootable Disk Image**
   ```bash
   dd if=/dev/zero of=bootloader.img bs=512 count=1
   dd if=bootloader.bin of=bootloader.img conv=notrunc
   ```

4. **Run the Bootloader**
   ```bash
   qemu-system-x86_64 -drive format=raw,file=bootloader.img
   ```

When executed successfully, you should see the message "Hello, Bootloader World!" displayed in QEMU.

## Technical Details

### File Structure

- `bootloader.asm`: Contains the assembly code that:
  - Prints characters to the screen using BIOS interrupts
  - Defines the bootable signature (`0xAA55`) required by the BIOS
- `bootloader.bin`: Binary file generated by NASM
- `bootloader.img`: Bootable disk image that meets BIOS requirements

### Key Concepts

- **Real-Mode Programming**
  - Uses 16-bit mode required by BIOS during boot
  - Loads at memory address `0x7C00`
- **BIOS Interrupts**
  - Uses interrupt `0x10` for screen output
- **Assembly Language**
  - Demonstrates fundamental x86 instructions

## Customization

To modify the displayed message, edit the `msg` section in `bootloader.asm`:

```asm
msg db "Your Custom Message Here!", 0
```

## Troubleshooting

### macOS-Specific Issues

1. **Homebrew Installation**
   ```bash
   # If Homebrew is not installed
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **NASM Not Found**
   ```bash
   brew install nasm
   # Verify installation
   nasm --version
   ```

3. **QEMU Issues**
   ```bash
   # Reinstall QEMU if needed
   brew uninstall qemu
   brew install qemu
   # Verify installation
   qemu-system-x86_64 --version
   ```

4. **Permission Issues**
   ```bash
   # If you encounter permission issues with dd command
   sudo dd if=/dev/zero of=bootloader.img bs=512 count=1
   sudo dd if=bootloader.bin of=bootloader.img conv=notrunc
   ```

5. **Binary File Missing**
   ```bash
   nasm -f bin bootloader.asm -o bootloader.bin
   # Verify file creation
   ls -l bootloader.bin
   ```

## Contributing

Contributions are welcome! Please feel free to:

- Open issues for bugs or feature requests
- Submit pull requests with improvements
- Share feedback on the documentation
- Test on different macOS versions and report compatibility

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the open-source community for tools and resources
- Inspired by tutorials on low-level programming and bootloader development
- Thanks to the Homebrew community for maintaining macOS packages
