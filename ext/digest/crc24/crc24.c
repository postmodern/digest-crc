/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:02:04 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 24
 *  - Poly          = 0x864cfb
 *  - XorIn         = 0xb704ce
 *  - ReflectIn     = False
 *  - XorOut        = 0x000000
 *  - ReflectOut    = False
 *  - Algorithm     = table-driven
 */

#include "crc24.h"
#include "crc24_table.h"

crc24_t crc24_update(crc24_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc24_table[15][d[ 0] ^ ((crc >> 16) & 0xff)] ^
		      crc24_table[14][d[ 1] ^ ((crc >>  8) & 0xff)] ^
		      crc24_table[13][d[ 2] ^ ((crc >>  0) & 0xff)] ^
		      crc24_table[12][d[ 3]                       ] ^
		      crc24_table[11][d[ 4]                       ] ^
		      crc24_table[10][d[ 5]                       ] ^
		      crc24_table[ 9][d[ 6]                       ] ^
		      crc24_table[ 8][d[ 7]                       ] ^
		      crc24_table[ 7][d[ 8]                       ] ^
		      crc24_table[ 6][d[ 9]                       ] ^
		      crc24_table[ 5][d[10]                       ] ^
		      crc24_table[ 4][d[11]                       ] ^
		      crc24_table[ 3][d[12]                       ] ^
		      crc24_table[ 2][d[13]                       ] ^
		      crc24_table[ 1][d[14]                       ] ^
		      crc24_table[ 0][d[15]                       ];
		crc &= 0xffffff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = ((crc >> 16) ^ *d) & 0xff;
		crc = (crc24_table[0][tbl_idx] ^ (crc << 8)) & 0xffffff;
		d++;
	}

	return crc & 0xffffff;
}
