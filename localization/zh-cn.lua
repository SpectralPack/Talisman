return {
        descriptions = {
                Mod = { 
                        Talisman = {
                                name = "Talisman",
                                text = {"本mod旨在提高Balatro的分数上限,并提供跳过得分动画的选项."},
                        }
                }
        }, 
        test = "j",
        talisman_vanilla = '原版 (e308)',
        talisman_bignum = '大数记数法BigNum (ee308)',
        talisman_omeganum = '欧米伽记数法OmegaNum',

        talisman_notation = '数值显示格式',

        talisman_notations_hypere = 'Hyper-E记数法',
        talisman_notations_letter = '字母记数法',
        talisman_notations_array = '数组记数法',
        
        talisman_string_A = '选择要启用的功能:',
        talisman_string_B = '禁用得分动画',
        talisman_string_C = '分数上限 (更改后重启游戏生效)',
        talisman_string_D = '计算中...',
        talisman_string_E = '终止计算',
        talisman_string_F = '已耗时: ',
        talisman_string_G = '待记分手牌: ',
        talisman_string_H = '上次出牌计算量: ',
        talisman_string_I = '未知',

        --These don't work out of the box because they would be called too early, find a workaround later?
        talisman_error_A = '未找到正确的Talisman文件夹.请确保该文件夹命名准确为"Talisman",而不是"Talisman-main"或其他名字.',
        talisman_error_B = '[Talisman] 字符串解包错误: ',
        talisman_error_C = '[Talisman] 字符串加载错误: '
}