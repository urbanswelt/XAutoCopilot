--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 29.01.14
-- Time: 20:39
-- To change this template use File | Settings | File Templates.
--

function find_dref_ascii(xac_table_dummy)

    local match_field=tmp_ascii
    local dref_setInt=xac_table_dummy[1][3]

    for i=1, #xac_table_dummy do
        if xac_table_dummy[i][2] == match_field then
            dref_setInt = xac_table_dummy [i][3]
        end
    end

    return dref_setInt
end

ascii_matrix={}
for i=1,3 do
    ascii_matrix[i]={}
    for j=1,3 do
        ascii_matrix[i][j]=0
    end
end

ascii_matrix[1][1]="A"
ascii_matrix[1][2]=65
ascii_matrix[1][3]="xac_click_a"

ascii_matrix[2][1]="B"
ascii_matrix[2][2]=66
ascii_matrix[2][3]="xac_click_b"

ascii_matrix[3][1]="C"
ascii_matrix[3][2]=67
ascii_matrix[3][3]="xac_click_c"

