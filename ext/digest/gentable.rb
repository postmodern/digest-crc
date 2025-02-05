require "erb"

class Integer
  def bitreflect(bits)
    dest = 0
    src  = self

    bits.times {
      dest = (dest << 1) | src[0]
      src >>= 1
    }

    dest
  end
end

def generate_table(path, table_name, bitwidth, polynomial, reflect_input)
  raise "wrong polynomial (expect odd number, but given #{polynomial})" unless polynomial.odd?

  slice_size = 16

  case bitwidth
  when  1.. 8
    bitclass =  8
  when  9..16
    bitclass = 16
  when 17..32
    bitclass = 32
  when 33..64
    bitclass = 64
  else
    raise "wrong bitwidth (expect 1..64, but given #{bitwidth})"
  end

  # If the bit input is NORMAL, reverse the bit direction after performing
  # the same table generation method as REFLECT.  This is because this
  # eliminates the need to consider the alignment of the upper bits.

  modified_poly = polynomial.bitreflect(bitwidth)

  table0 = 256.times.map { |i|
    8.times {
      if i[0].zero?
        i = (i >> 1)
      else
        i = (i >> 1) ^ modified_poly
      end
    }

    i
  }

  table = [table0]

  (1...slice_size).each do |s|
    table_prev = table[s - 1]

    table << 256.times.map { |i|
      e = table_prev[i]
      (e >> 8) ^ table0[0xff & e]
    }
  end

  unless reflect_input
    table.map! { |t|
      256.times.map { |i|
        idx = i.bitreflect(8)
        t[idx].bitreflect(bitwidth)
      }
    }
  end

  crcint            = "uint#{bitclass}_t"
  step              = bitclass > 16 ? 4 : 8
  generator         = File.basename(__FILE__)
  templatepath      = File.join(__dir__, "table.h.erb")
  templatesrc       = File.read(templatepath)
  template          = ERB.new(templatesrc, trim_mode: "%")
  template.filename = templatepath

  File.binwrite(path, template.result(binding))

  slice_size
end
