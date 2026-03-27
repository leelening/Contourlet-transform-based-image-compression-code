# Contourlet Transform Based Image Compression

[![MATLAB](https://img.shields.io/badge/MATLAB-0076A8?style=flat&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Image Processing](https://img.shields.io/badge/Image%20Processing-Contourlet-orange)](https://en.wikipedia.org/wiki/Contourlet)
[![Undergraduate](https://img.shields.io/badge/Level-Undergraduate-green)](https://en.wikipedia.org/wiki/Harbin_Institute_of_Technology)

MATLAB implementation of image compression using Contourlet transform - undergraduate dissertation project.

## Overview

This repository contains MATLAB code implementing image compression using the **Contourlet transform**, a multi-scale geometric analysis tool for image processing. The Contourlet transform is particularly effective for capturing edges and contours in images, making it superior to traditional wavelet transforms for image compression.

This was developed as part of an undergraduate dissertation at Harbin Institute of Technology (哈尔滨工业大学).

## What is Contourlet Transform?

The Contourlet transform is a directional multiresolution image representation that offers:

- **Multi-scale Analysis**: Like wavelets, captures features at different scales
- **Directional Selectivity**: Captures edges in multiple directions
- **Anisotropy**: Efficient representation of contours and textures
- **Sparse Representation**: Concentrates image energy in few coefficients

### Comparison with Wavelets

| Transform | Directional | Multi-scale | Best For |
|-----------|-------------|-------------|----------|
| Wavelet | Limited | Yes | Point singularities |
| Contourlet | Yes | Yes | Edges and contours |

## Features

- 📊 **Contourlet Transform**: Multi-directional, multi-scale decomposition
- 🗜️ **Image Compression**: Sparse representation for efficient coding
- 📈 **Performance Analysis**: PSNR, compression ratio metrics
- 🖼️ **Visualization**: Transform coefficient visualization

## Tech Stack

- **Language**: MATLAB
- **Toolbox**: Image Processing Toolbox
- **Requirements**: MATLAB R2010a or later

## Prerequisites

- MATLAB (R2010a or later recommended)
- Image Processing Toolbox
- Contourlet Toolbox (if using external implementation)

## Installation

```bash
# Clone the repository
git clone https://github.com/leelening/Contourlet-transform-based-image-compression-code.git
cd Contourlet-transform-based-image-compression-code

# Open in MATLAB
# Run the main script
```

## Usage

### Running the Code

```matlab
% In MATLAB Command Window
run('main.m')  % or the main script filename

% The script will:
% 1. Load test images
% 2. Apply Contourlet transform
% 3. Quantize coefficients
% 4. Encode and reconstruct
% 5. Calculate compression metrics
```

### Example Workflow

```matlab
% Load image
img = imread('test_image.jpg');

% Apply Contourlet transform
% [transform coefficients]

% Quantize and encode coefficients
% [compression steps]

% Reconstruct image
reconstructed = inverse_contourlet(coefficients);

% Calculate metrics
psnr_value = psnr(reconstructed, img);
compression_ratio = original_size / compressed_size;
```

## Project Structure

```
.
├── *.m                    # MATLAB scripts
├── functions/             # Utility functions
├── images/                # Test images
├── results/               # Output results
└── README.md              # This file
```

## Algorithm Details

### Laplacian Pyramid

Decomposes image into multiple scales:
- Captures point discontinuities
- Separates high and low frequency components

### Directional Filter Bank

Applies directional filtering at each scale:
- Captures directional edges
- Groups wavelet coefficients along contours
- Enables anisotropic decomposition

### Quantization and Encoding

- Threshold small coefficients
- Quantize remaining coefficients
- Entropy coding (Huffman/Arithmetic)

## Evaluation Metrics

- **PSNR (Peak Signal-to-Noise Ratio)**: Quality metric
- **SSIM (Structural Similarity Index)**: Perceptual quality
- **Compression Ratio**: Size reduction
- **Bitrate**: Bits per pixel

## Undergraduate Dissertation

- **Institution**: Harbin Institute of Technology
- **Year**: 2014
- **Degree**: Bachelor of Science
- **Major**: Computer Science

## Key Concepts

- Multi-scale geometric analysis
- Directional multiresolution representations
- Image compression fundamentals
- Rate-distortion trade-offs
- Sparse image representations

## References

- Do, M. N., & Vetterli, M. (2005). The contourlet transform: An efficient directional multiresolution image representation. *IEEE Transactions on Image Processing*.
- Lu, Y., & Do, M. N. (2003). CRISP-contourlets: a critically sampled directional multiresolution image representation.

## License

Academic use only.

## Author

**Lening Li**
- B.S. in Computer Science (Harbin Institute of Technology, 2014)
- M.S. in Computer Science (WPI, 2016)
- Ph.D. in Robotics Engineering (WPI, 2022)

## Acknowledgments

- Harbin Institute of Technology
- Dissertation advisor and committee
- Image processing research community
