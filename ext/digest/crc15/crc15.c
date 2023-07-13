/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:30:57 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 15
 *  - Poly          = 0x4599
 *  - XorIn         = 0x0000
 *  - ReflectIn     = False
 *  - XorOut        = 0x0000
 *  - ReflectOut    = False
 *  - Algorithm     = table-driven
 */

#include "crc15.h"
#include "crc15_table.h"

crc15_t crc15_update(crc15_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc15_table[15][d[ 0] ^ ((crc >>  7) & 0xff)] ^
		      crc15_table[14][d[ 1] ^ ((crc <<  1) & 0xff)] ^
		      crc15_table[13][d[ 2]                       ] ^
		      crc15_table[12][d[ 3]                       ] ^
		      crc15_table[11][d[ 4]                       ] ^
		      crc15_table[10][d[ 5]                       ] ^
		      crc15_table[ 9][d[ 6]                       ] ^
		      crc15_table[ 8][d[ 7]                       ] ^
		      crc15_table[ 7][d[ 8]                       ] ^
		      crc15_table[ 6][d[ 9]                       ] ^
		      crc15_table[ 5][d[10]                       ] ^
		      crc15_table[ 4][d[11]                       ] ^
		      crc15_table[ 3][d[12]                       ] ^
		      crc15_table[ 2][d[13]                       ] ^
		      crc15_table[ 1][d[14]                       ] ^
		      crc15_table[ 0][d[15]                       ];
		crc &= 0x7fff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = ((crc >> 7) ^ *d) & 0xff;
		crc = (crc15_table[0][tbl_idx] ^ (crc << 8)) & 0x7fff;
		d++;
	}

	return crc & 0x7fff;
}
