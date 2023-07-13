/*
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:33:07 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 32
 *  - Poly          = 0x04c11db7
 *  - XorIn         = 0xffffffff
 *  - ReflectIn     = True
 *  - XorOut        = 0x00000000
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc32_jam.h"
#include "crc32_jam_table.h"

crc32_t crc32_jam_update(crc32_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc32_jam_table[15][d[ 0] ^ ((crc >>  0) & 0xff)] ^
		      crc32_jam_table[14][d[ 1] ^ ((crc >>  8) & 0xff)] ^
		      crc32_jam_table[13][d[ 2] ^ ((crc >> 16) & 0xff)] ^
		      crc32_jam_table[12][d[ 3] ^ ((crc >> 24) & 0xff)] ^
		      crc32_jam_table[11][d[ 4]                       ] ^
		      crc32_jam_table[10][d[ 5]                       ] ^
		      crc32_jam_table[ 9][d[ 6]                       ] ^
		      crc32_jam_table[ 8][d[ 7]                       ] ^
		      crc32_jam_table[ 7][d[ 8]                       ] ^
		      crc32_jam_table[ 6][d[ 9]                       ] ^
		      crc32_jam_table[ 5][d[10]                       ] ^
		      crc32_jam_table[ 4][d[11]                       ] ^
		      crc32_jam_table[ 3][d[12]                       ] ^
		      crc32_jam_table[ 2][d[13]                       ] ^
		      crc32_jam_table[ 1][d[14]                       ] ^
		      crc32_jam_table[ 0][d[15]                       ];
		crc &= 0xffffffff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = (crc ^ *d) & 0xff;
		crc = (crc32_jam_table[0][tbl_idx] ^ (crc >> 8)) & 0xffffffff;
		d++;
	}

	return crc & 0xffffffff;
}
