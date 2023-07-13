/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:33:36 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 64
 *  - Poly          = 0x42f0e1eba9ea3693
 *  - XorIn         = 0xffffffffffffffff
 *  - ReflectIn     = True
 *  - XorOut        = 0xffffffffffffffff
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc64_xz.h"
#include "crc64_xz_table.h"

crc64_t crc64_xz_update(crc64_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc64_xz_table[15][d[ 0] ^ ((crc >>  0) & 0xff)] ^
		      crc64_xz_table[14][d[ 1] ^ ((crc >>  8) & 0xff)] ^
		      crc64_xz_table[13][d[ 2] ^ ((crc >> 16) & 0xff)] ^
		      crc64_xz_table[12][d[ 3] ^ ((crc >> 24) & 0xff)] ^
		      crc64_xz_table[11][d[ 4] ^ ((crc >> 32) & 0xff)] ^
		      crc64_xz_table[10][d[ 5] ^ ((crc >> 40) & 0xff)] ^
		      crc64_xz_table[ 9][d[ 6] ^ ((crc >> 48) & 0xff)] ^
		      crc64_xz_table[ 8][d[ 7] ^ ((crc >> 56) & 0xff)] ^
		      crc64_xz_table[ 7][d[ 8]                       ] ^
		      crc64_xz_table[ 6][d[ 9]                       ] ^
		      crc64_xz_table[ 5][d[10]                       ] ^
		      crc64_xz_table[ 4][d[11]                       ] ^
		      crc64_xz_table[ 3][d[12]                       ] ^
		      crc64_xz_table[ 2][d[13]                       ] ^
		      crc64_xz_table[ 1][d[14]                       ] ^
		      crc64_xz_table[ 0][d[15]                       ];
		crc &= 0xffffffffffffffff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = (crc ^ *d) & 0xff;
		crc = (crc64_xz_table[0][tbl_idx] ^ (crc >> 8)) & 0xffffffffffffffff;
		d++;
	}

	return crc & 0xffffffffffffffff;
}
