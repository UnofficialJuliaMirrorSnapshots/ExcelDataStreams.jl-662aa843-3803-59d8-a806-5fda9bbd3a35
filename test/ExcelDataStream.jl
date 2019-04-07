using DataStreams
using DataFrames

filename = Pkg.dir( "ExcelDataStreams", "test", "test.xlsx" )

columnindices = [0,2]
names = [:date, :Fibonacci]
eltypes = [Date, Int]
skipstart = 2

ed = ExcelDataStreams.ExcelDataStream(
    filename,
    columnindices = columnindices,
    names = names,
    eltypes = eltypes,
    skipstart = skipstart,
)

df = Data.close!( Data.stream!( ed, DataFrame ) )
assert( size(df)==(9,2) )
assert( unique(diff(df[:date])) == [Dates.Day(1)] )
assert( all(df[3:end,:Fibonacci] .== df[1:end-2,:Fibonacci] + df[2:end-1,:Fibonacci]) )
