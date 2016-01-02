public class Recursive extends Lista {
    /* haskell length
     * len [] = 0
     * len (x:xs) = 1 + len xs
     */
    int len(Lista a) { 
        if (a.isEmpty())  
            return 0;
        else
            return 1 + len(a.tail);
    }
    
    int acclen(Lista a, int cnt) {
        if (a.isEmpty())
            return cnt;
        else
            return acclen(a.tail, cnt+1);
        }
    
    /* haskell find
     * find _ [] = 0
     * find y (x:xs)
     *      | x == y	= 0
     *      | otherwise	= 1 + find y xs
     */
    
    int find(int n, Lista a) {
        if (a.isEmpty())
            return 0;
        if (a.element.equals(n)) 
            return 0; 
        else
            return 1 + find(n, a.tail);
            
        }
    
    int accfind(int n, Lista a, int cnt) {
        if (a.isEmpty())
            return cnt;
        if (a.element.equals(n))
            return cnt;
        else
            return accfind(n, a.tail, cnt+1);
    }
    
    /* haskell count
     * count _ [] = 0
     * count y (x:xs)
     *     | x == y     = 1 + count y xs
     *     | otherwise  = count y xs
     */
    int count(int n, Lista a) { 
        if (a.isEmpty())
            return 0;
        if (a.element.equals(n))
            return 1 + count(n, a.tail);
        else
            return count(n, a.tail);
    }

    int accCount(int n, Lista a, int cnt) {
        if (a.isEmpty()) 
            return cnt;
        if (a.element.equals(n))
            return accCount(n, a.tail, cnt+1);
        else
            return accCount(n, a.tail, cnt);
            
        }
    }
