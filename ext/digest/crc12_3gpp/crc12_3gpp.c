/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:30:42 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 12
 *  - Poly          = 0x80f
 *  - XorIn         = 0x000
 *  - ReflectIn     = False
 *  - XorOut        = 0x000
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc12_3gpp.h"
#include "crc12_3gpp_table.h"

crc12_t crc12_3gpp_update(crc12_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc12_3gpp_table[15][d[ 0] ^ ((crc >>  4) & 0xff)] ^
		      crc12_3gpp_table[14][d[ 1] ^ ((crc <<  4) & 0xff)] ^
		      crc12_3gpp_table[13][d[ 2]                       ] ^
		      crc12_3gpp_table[12][d[ 3]                       ] ^
		      crc12_3gpp_table[11][d[ 4]                       ] ^
		      crc12_3gpp_table[10][d[ 5]                       ] ^
		      crc12_3gpp_table[ 9][d[ 6]                       ] ^
		      crc12_3gpp_table[ 8][d[ 7]                       ] ^
		      crc12_3gpp_table[ 7][d[ 8]                       ] ^
		      crc12_3gpp_table[ 6][d[ 9]                       ] ^
		      crc12_3gpp_table[ 5][d[10]                       ] ^
		      crc12_3gpp_table[ 4][d[11]                       ] ^
		      crc12_3gpp_table[ 3][d[12]                       ] ^
		      crc12_3gpp_table[ 2][d[13]                       ] ^
		      crc12_3gpp_table[ 1][d[14]                       ] ^
		      crc12_3gpp_table[ 0][d[15]                       ];
		crc &= 0xfff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = ((crc >> 4) ^ *d) & 0xff;
		crc = (crc12_3gpp_table[0][tbl_idx] ^ (crc << 8)) & 0xfff;
		d++;
	}

	return crc & 0xfff;
}
