# JPEG-Compression-in-Assembly-RISCV
# JPEG Compression via Assembly Language for RISC-V32I using RARS simulation Tool

## Project Overview
This project aims to implement JPEG compression using assembly language specifically for the RISC-V32I architecture. The focus is on creating an efficient, low-level algorithm to compress JPEG images, leveraging the unique features and capabilities of the RISC-V32I instruction set. RARS simulation tool was used for implementation and testing.

## Features
- **Efficient Compression Algorithm**: Utilizes custom assembly routines for optimal performance.
- **RISC-V32I Optimization**: Tailored specifically for the RISC-V32I architecture to take full advantage of its instruction set.
- **Minimalistic Design**: Strives for a clean, understandable codebase with a focus on performance and maintainability.

## Project Components
The project is broken down into several key components:

1. **RGB -> YCbCr Conversion and Level-Shifting**: Converts the color space of an 8x8 image block from RGB to Y (Luminance).
2. **DCT-II Transform**: Implements the AA&N algorithm for both column-wise and row-wise DCT-I transforms.
3. **Quantization**: Applies a provided Quantization table to the DCT coefficients.
4. **Zigzagging**: Reorders DCT coefficients in a 'zigzag' pattern to prepare for compression.
5. **Run-Length Encoding (RLE)**: Encodes the image using RLE to compress sequences of zeros.
6. **Huffman Encoding**: Further compresses the image using a provided Huffman table.
7. **Bitstream Concatenation**: Combines variable length bit streams into an array of 8-bit values.
