function acHufCodeOut=YAcHufCode(a)
%编码如果采用二叉树则首先需要在树中找到对应的叶节点，
%然后逆着往树根走，需要不断的选择判断，所以从速度角度
%而言，不如直接用选择分之的方法，这相当于用一棵二层多叉数来搜索
switch a(1)
    case 0
        switch a(2)
            case 0
                acHufCodeOut=[1 0 1 0];
            case 1
                acHufCodeOut=[0 0];
            case 2
                acHufCodeOut=[0 1];
            case 3
                acHufCodeOut=[1 0 0 ];
            case 4 
                acHufCodeOut=[1 0 1 1];
            case 5
                acHufCodeOut=[1 1 0 1 0];
            case 6
                acHufCodeOut=[1 1 1 1 0 0 0];
            case 7
                acHufCodeOut=[1 1 1 1 1 0 0 0];
            case 8
                acHufCodeOut=[1 1 1 1 1 1 0 1 1 0];
            case 9
                acHufCodeOut=[ones(1,9) zeros(1,5) 1 0];
            case 10
                acHufCodeOut=[ones(1,9) zeros(1,5) 1 1];
            otherwise
                a(2)
                pause
        end
    case 1
        switch a(2)
            case 1
                acHufCodeOut=[1 1 0 0];
            case 2
                acHufCodeOut=[1 1 0 1 1];
            case 3
                acHufCodeOut=[1 1 1 1 0 0 1];
            case 4 
                acHufCodeOut=[ones(1,5) 0 1 1 0];
            case 5
                acHufCodeOut=[ones(1,7) 0 1 1 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 0 0 0 1 0 0];
            case 7
                acHufCodeOut=[ones(1,9) 0 0 0 0 1 0 1];
            case 8
                acHufCodeOut=[ones(1,9) 0 0 0 0 1 1 0];
            case 9
                acHufCodeOut=[ones(1,9) 0 0 0 0 1 1 1];
            case 10
                acHufCodeOut=[ones(1,9) 0 0 0 1 0 0 0];
            otherwise
                a(2)
                pause
        end
    case 2
        switch a(2)
            case 1
                acHufCodeOut=[1 1 1 0 0];
            case 2
                acHufCodeOut=[ones(1,5) 0 0 1];
            case 3
                acHufCodeOut=[ones(1,6) 0 1 1 1];
            case 4 
                acHufCodeOut=[ones(1,8) 0 1 0 0];
            case 5
                acHufCodeOut=[ones(1,9) 0 0 0 1 0 0 1];
            case 6
                acHufCodeOut=[ones(1,9) 0 0 0 1 0 1 0];
            case 7
                acHufCodeOut=[ones(1,9) 0 0 0 1 0 1 1];
            case 8
                acHufCodeOut=[ones(1,9) 0 0 0 1 1 0 0];
            case 9
                acHufCodeOut=[ones(1,9) 0 0 0 1 1 0 1];
            case 10
                acHufCodeOut=[ones(1,9) 0 0 0 1 1 1 0];
            otherwise
                a(2)
                pause
        end
    case 3
        switch a(2)
            case 1
                acHufCodeOut=[1 1 1 0 1 0];
            case 2
                acHufCodeOut=[ones(1,5) 0 1 1 1];
            case 3
                acHufCodeOut=[ones(1,8) 0 1 0 1];
            case 4 
                acHufCodeOut=[ones(1,9) 0 0 0 1 1 1 1];
            case 5
                acHufCodeOut=[ones(1,9) 0 0 1 0 0 0 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 0 1 0 0 0 1];
            case 7
                acHufCodeOut=[ones(1,9) 0 0 1 0 0 1 0];
            case 8
                acHufCodeOut=[ones(1,9) 0 0 1 0 0 1 1];
            case 9
                acHufCodeOut=[ones(1,9) 0 0 1 0 1 0 0];
            case 10
                acHufCodeOut=[ones(1,9) 0 0 1 0 1 0 1];
            otherwise
                a(2)
                pause
        end
    case 4
        switch a(2)
            case 1
                acHufCodeOut=[1 1 1 0 1 1];
            case 2
                acHufCodeOut=[ones(1,7) 0 0 0];
            case 3
                acHufCodeOut=[ones(1,9) 0 0 1 0 1 1 0];
            case 4 
                acHufCodeOut=[ones(1,9) 0 0 1 0 1 1 1];
            case 5
                acHufCodeOut=[ones(1,9) 0 0 1 1 0 0 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 0 1 1 0 0 1];
            case 7
                acHufCodeOut=[ones(1,9) 0 0 1 1 0 1 0];
            case 8
                acHufCodeOut=[ones(1,9) 0 0 1 1 0 1 1];
            case 9
                acHufCodeOut=[ones(1,9) 0 0 1 1 1 0 0];
            case 10
                acHufCodeOut=[ones(1,9) 0 0 1 1 1 0 1];
            otherwise
                a(2)
                pause
        end
    case 5
        switch a(2)
            case 1
                acHufCodeOut=[1 1 1 1 0 1 0];
            case 2
                acHufCodeOut=[ones(1,7) 0 1 1 1];
            case 3
                acHufCodeOut=[ones(1,9) 0 0 1 1 1 1 0];
            case 4 
                acHufCodeOut=[ones(1,9) 0 0 1 1 1 1 1];
            case 5
                acHufCodeOut=[ones(1,9) 0 1 0 0 0 0 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 1 0 0 0 0 1];
            case 7
                acHufCodeOut=[ones(1,9) 0 1 0 0 0 1 0];
            case 8
                acHufCodeOut=[ones(1,9) 0 1 0 0 0 1 1];
            case 9
                acHufCodeOut=[ones(1,9) 0 1 0 0 1 0 0];
            case 10
                acHufCodeOut=[ones(1,9) 0 1 0 0 1 0 1];
            otherwise
                a(2)
                pause
        end
    case 6
        switch a(2)
            case 1
                acHufCodeOut=[1 1 1 1 0 1 1];
            case 2
                acHufCodeOut=[ones(1,8) 0 1 1 0];
            case 3
                acHufCodeOut=[ones(1,9) 0 1 0 0 1 1 0];
            case 4 
                acHufCodeOut=[ones(1,9) 0 1 0 0 1 1 1];
            case 5
                acHufCodeOut=[ones(1,9) 0 1 0 1 0 0 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 1 0 1 0 0 1];
            case 7
                acHufCodeOut=[ones(1,9) 0 1 0 1 0 1 0];
            case 8
                acHufCodeOut=[ones(1,9) 0 1 0 1 0 1 1];
            case 9
                acHufCodeOut=[ones(1,9) 0 1 0 1 1 0 0];
            case 10
                acHufCodeOut=[ones(1,9) 0 1 0 1 1 0 1];
            otherwise
                a(2)
                pause
        end
    case 7
        switch a(2)
            case 1
                acHufCodeOut=[1 1 1 1 1 0 1 0];
            case 2
                acHufCodeOut=[ones(1,8) 0 1 1 1];
            case 3
                acHufCodeOut=[ones(1,9) 0 1 0 1 1 1 0];
            case 4 
                acHufCodeOut=[ones(1,9) 0 1 0 1 1 1 1];
            case 5
                acHufCodeOut=[ones(1,9) 0 1 1 0 0 0 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 1 1 0 0 0 1];
            case 7
                acHufCodeOut=[ones(1,9) 0 1 1 0 0 1 0];
            case 8
                acHufCodeOut=[ones(1,9) 0 1 1 0 0 1 1];
            case 9
                acHufCodeOut=[ones(1,9) 0 1 1 0 1 0 0];
            case 10
                acHufCodeOut=[ones(1,9) 0 1 1 0 1 0 1];
           otherwise
                a(2)
                pause
        end
    case 8
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,6) 0 0 0];
            case 2
                acHufCodeOut=[ones(1,9) 0 0 0 0 0 0];
            case 3
                acHufCodeOut=[ones(1,9) 0 1 1 0 1 1 0];
            case 4 
                acHufCodeOut=[ones(1,9) 0 1 1 0 1 1 1];
            case 5
                acHufCodeOut=[ones(1,9) 0 1 1 1 0 0 0];
            case 6
                acHufCodeOut=[ones(1,9) 0 1 1 1 0 0 1];
            case 7
                acHufCodeOut=[ones(1,9) 0 1 1 1 0 1 0];
            case 8
                acHufCodeOut=[ones(1,9) 0 1 1 1 0 1 1];
            case 9
                acHufCodeOut=[ones(1,9) 0 1 1 1 1 0 0];
            case 10
                acHufCodeOut=[ones(1,9) 0 1 1 1 1 0 1];
            otherwise
                a(2)
                pause
        end
    case 9
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,6) 0 0 1];
            case 2
                acHufCodeOut=[ones(1,9) 0 1 1 1 1 1 0];
            case 3
                acHufCodeOut=[ones(1,9) 0 1 1 1 1 1 1];
            case 4 
                acHufCodeOut=[ones(1,9) 1 0 0 0 0 0 0];
            case 5
                acHufCodeOut=[ones(1,9) 1 0 0 0 0 0 1];
            case 6
                acHufCodeOut=[ones(1,9) 1 0 0 0 0 1 0];
            case 7
                acHufCodeOut=[ones(1,9) 1 0 0 0 0 1 1];
            case 8
                acHufCodeOut=[ones(1,9) 1 0 0 0 1 0 0];
            case 9
                acHufCodeOut=[ones(1,9) 1 0 0 0 1 0 1];
            case 10
                acHufCodeOut=[ones(1,9) 1 0 0 0 1 1 0];
            otherwise
                a(2)
                pause
        end
    case 10
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,6) 0 1 0];
            case 2
                acHufCodeOut=[ones(1,10) 0 0 0 1 1 1];
            case 3
                acHufCodeOut=[ones(1,10) 0 0 1 0 0 0];
            case 4 
                acHufCodeOut=[ones(1,10) 0 0 1 0 0 1];
            case 5
                acHufCodeOut=[ones(1,10) 0 0 1 0 1 0];
            case 6
                acHufCodeOut=[ones(1,10) 0 0 1 0 1 1];
            case 7
                acHufCodeOut=[ones(1,10) 0 0 1 1 0 0];
            case 8
                acHufCodeOut=[ones(1,10) 0 0 1 1 0 1];
            case 9
                acHufCodeOut=[ones(1,10) 0 0 1 1 1 0];
            case 10
                acHufCodeOut=[ones(1,10) 0 0 1 1 1 1];
            otherwise
                a(2)
                pause
        end
    case 11
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,7) 0 0 1];
            case 2
                acHufCodeOut=[ones(1,10) 0 1 0 0 0 0];
            case 3
                acHufCodeOut=[ones(1,10) 0 1 0 0 0 1];
            case 4 
                acHufCodeOut=[ones(1,10) 0 1 0 0 1 0];
            case 5
                acHufCodeOut=[ones(1,10) 0 1 0 0 1 1];
            case 6
                acHufCodeOut=[ones(1,10) 0 1 0 1 0 0];
            case 7
                acHufCodeOut=[ones(1,10) 0 1 0 1 0 1];
            case 8
                acHufCodeOut=[ones(1,10) 0 1 0 1 1 0];
            case 9
                acHufCodeOut=[ones(1,10) 0 1 0 1 1 1];
            case 10
                acHufCodeOut=[ones(1,10) 0 1 1 0 0 0];
            otherwise
                a(2)
                pause
        end
    case 12
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,7) 0 1 0];
            case 2
                acHufCodeOut=[ones(1,10) 0 1 1 0 0 1];
            case 3
                acHufCodeOut=[ones(1,10) 0 1 1 0 1 0];
            case 4 
                acHufCodeOut=[ones(1,10) 0 1 1 0 1 1];
            case 5
                acHufCodeOut=[ones(1,10) 0 1 1 1 0 0];
            case 6
                acHufCodeOut=[ones(1,10) 0 1 1 1 0 1];
            case 7
                acHufCodeOut=[ones(1,10) 0 1 1 1 1 0];
            case 8
                acHufCodeOut=[ones(1,10) 0 1 1 1 1 1];
            case 9
                acHufCodeOut=[ones(1,10) 1 0 0 0 0 0];
            case 10
                acHufCodeOut=[ones(1,10) 1 0 0 0 0 1];
            otherwise
                a(2)
                pause
        end
    case 13
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,8) 0 0 0];
            case 2
                acHufCodeOut=[ones(1,11) 0 0 0 1 0];
            case 3
                acHufCodeOut=[ones(1,11) 0 0 0 1 1];
            case 4 
                acHufCodeOut=[ones(1,11) 0 0 1 0 0];
            case 5
                acHufCodeOut=[ones(1,11) 0 0 1 0 1];
            case 6
                acHufCodeOut=[ones(1,11) 0 0 1 1 0];
            case 7
                acHufCodeOut=[ones(1,11) 0 0 1 1 1];
            case 8
                acHufCodeOut=[ones(1,11) 0 1 0 0 0];
            case 9
                acHufCodeOut=[ones(1,11) 0 1 0 0 1];
            case 10
                acHufCodeOut=[ones(1,11) 0 1 0 1 0];
            otherwise
                a(2)
                pause
        end
    case 14
        switch a(2)
            case 1
                acHufCodeOut=[ones(1,11) 0 1 0 1 1];
            case 2
                acHufCodeOut=[ones(1,11) 0 1 1 0 0];
            case 3
                acHufCodeOut=[ones(1,11) 0 1 1 0 1];
            case 4 
                acHufCodeOut=[ones(1,11) 0 1 1 1 0];
            case 5
                acHufCodeOut=[ones(1,11) 0 1 1 1 1];
            case 6
                acHufCodeOut=[ones(1,11) 1 0 0 0 0];
            case 7
                acHufCodeOut=[ones(1,11) 1 0 0 0 1];
            case 8
                acHufCodeOut=[ones(1,11) 1 0 0 1 0];
            case 9
                acHufCodeOut=[ones(1,11) 1 0 0 1 1];
            case 10
                acHufCodeOut=[ones(1,11) 1 0 1 0 0];
            otherwise
                a(2)
                pause
        end
    case 15
        switch a(2)
            case 0
                acHufCodeOut=[ones(1,8) 0 0 1];
            case 1
                acHufCodeOut=[ones(1,12) 0 1 0 1];
            case 2
                acHufCodeOut=[ones(1,12) 0 1 1 0];
            case 3
                acHufCodeOut=[ones(1,12) 0 1 1 1];
            case 4 
                acHufCodeOut=[ones(1,12) 1 0 0 0];
            case 5
                acHufCodeOut=[ones(1,12) 1 0 0 1];
            case 6
                acHufCodeOut=[ones(1,12) 1 0 1 0];
            case 7
                acHufCodeOut=[ones(1,12) 1 0 1 1];
            case 8
                acHufCodeOut=[ones(1,12) 1 1 0 0];
            case 9
                acHufCodeOut=[ones(1,12) 1 1 0 1];
            case 10
                acHufCodeOut=[ones(1,12) 1 1 1 1];
            otherwise
                a(2)
                pause
        end
    otherwise
        a(1)
        pause
        
        
        
        
        
end