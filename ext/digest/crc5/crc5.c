/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:29:44 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 5
 *  - Poly          = 0x05
 *  - XorIn         = 0x1f
 *  - ReflectIn     = True
 *  - XorOut        = 0x1f
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc5.h"
#include "crc5_table.h"

crc5_t crc5_update(crc5_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc5_table[15][d[ 0] ^ crc] ^
		      crc5_table[14][d[ 1]      ] ^
		      crc5_table[13][d[ 2]      ] ^
		      crc5_table[12][d[ 3]      ] ^
		      crc5_table[11][d[ 4]      ] ^
		      crc5_table[10][d[ 5]      ] ^
		      crc5_table[ 9][d[ 6]      ] ^
		      crc5_table[ 8][d[ 7]      ] ^
		      crc5_table[ 7][d[ 8]      ] ^
		      crc5_table[ 6][d[ 9]      ] ^
		      crc5_table[ 5][d[10]      ] ^
		      crc5_table[ 4][d[11]      ] ^
		      crc5_table[ 3][d[12]      ] ^
		      crc5_table[ 2][d[13]      ] ^
		      crc5_table[ 1][d[14]      ] ^
		      crc5_table[ 0][d[15]      ];
		crc &= 0x1f;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = (crc ^ *d) & 0xff;
		crc = (crc5_table[0][tbl_idx]) & 0x1f;
		d++;
	}

	return crc & 0x1f;
}
