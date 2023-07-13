/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:02:50 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 8
 *  - Poly          = 0x31
 *  - XorIn         = 0x00
 *  - ReflectIn     = True
 *  - XorOut        = 0x00
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc8_1wire.h"
#include "crc8_1wire_table.h"

crc8_t crc8_1wire_update(crc8_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc8_1wire_table[15][d[ 0] ^ crc] ^
		      crc8_1wire_table[14][d[ 1]      ] ^
		      crc8_1wire_table[13][d[ 2]      ] ^
		      crc8_1wire_table[12][d[ 3]      ] ^
		      crc8_1wire_table[11][d[ 4]      ] ^
		      crc8_1wire_table[10][d[ 5]      ] ^
		      crc8_1wire_table[ 9][d[ 6]      ] ^
		      crc8_1wire_table[ 8][d[ 7]      ] ^
		      crc8_1wire_table[ 7][d[ 8]      ] ^
		      crc8_1wire_table[ 6][d[ 9]      ] ^
		      crc8_1wire_table[ 5][d[10]      ] ^
		      crc8_1wire_table[ 4][d[11]      ] ^
		      crc8_1wire_table[ 3][d[12]      ] ^
		      crc8_1wire_table[ 2][d[13]      ] ^
		      crc8_1wire_table[ 1][d[14]      ] ^
		      crc8_1wire_table[ 0][d[15]      ];
		crc &= 0xff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = (crc ^ *d) & 0xff;
		crc = (crc8_1wire_table[0][tbl_idx]) & 0xff;
		d++;
	}

	return crc & 0xff;
}
