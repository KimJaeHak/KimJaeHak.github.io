---
title: "C# Polygon InterSection"
categories:
 - C#
tags:
 - C#
 - Graphics
 - MathUtil
published: false
---

### 2D Polygon Intersecton Algorithm(폴리곤 충돌 체크)
```c#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PolygonInterSection
{
    class Program
    {
        static void Main(string[] args)
        {
        }
    }



    public static class MathUtil
    {
        public static bool CheckPolygonIntersection(List<ItemPoint2DF> left, List<ItemPoint2DF> right)
        {
            bool isIntersection = false;

            var leftMinPos = MinPointOf(left);
            var leftMaxPos = MaxPointOf(left);
            var rightMinPos = MinPointOf(right);
            var rightMaxPos = MaxPointOf(right);

            var leftBoundBox = new OrthogonalBoundBox2D(new ScalarValue2D(leftMinPos.X, leftMinPos.Y),
                new ScalarValue2D(leftMaxPos.X, leftMaxPos.Y));
            var rightBoundBox = new OrthogonalBoundBox2D(new ScalarValue2D(rightMinPos.X, rightMinPos.Y),
                new ScalarValue2D(rightMaxPos.X, rightMaxPos.Y));

            //InterSection Check Process
            do
            {
                //Boundbox check로 Polygon Intersection아 아닌경우 Detail 판단이 불필요.
                if (!leftBoundBox.RangeX.IsIntersected(rightBoundBox.RangeX) &&
                    !leftBoundBox.RangeY.IsIntersected(rightBoundBox.RangeY))
                {
                    isIntersection = false;
                    break;
                }

                //Bound Box 포함 여부 판단.
                var containState = CheckContainmentBoundBox(leftBoundBox, rightBoundBox);

                //서로 포함 관계에 있는 경우.
                if (containState != enContainState.None)
                {
                    var inPolygon = left;
                    var outPolygon = right;

                    if (containState == enContainState.LeftContainRight)
                    {
                        Swap.Change(ref inPolygon, ref outPolygon);
                    }

                    if (inPolygon.Any(point => PolygonChecker.PointInPolygon(point, outPolygon)))
                    {
                        isIntersection = true;
                        break;
                    }

                }

                //위 경우의 수를 빠져 나온경우 최종적으로 아래의 로직으로 확인.
                //Segment Intersection 판단. (마른모와 사각형 경우 Point In/out 으로는 검출 불가)
                isIntersection = CheckSegmentIntersection(left, right);

            } while (false); //break를 사용하기 위한 One Loop


            return isIntersection;
        }
        private static enContainState CheckContainmentBoundBox(OrthogonalBoundBox2D leftBoundBox, OrthogonalBoundBox2D rightBoundBox)
        {
            var lb = leftBoundBox;
            var rb = rightBoundBox;

            var funcLeftContainsRight = new Func<OrthogonalBoundBox2D, OrthogonalBoundBox2D, bool>((pLb, pRb) =>
            {
                if (pLb.RangeX.Contains(pRb.Min.X) && pLb.RangeX.Contains(pRb.Max.X))
                {
                    if (pLb.RangeY.Contains(pRb.Min.Y) && pLb.RangeY.Contains(pRb.Max.Y))
                        return true;
                }

                return false;
            });

            if (funcLeftContainsRight(lb, rb))
            {
                return enContainState.LeftContainRight;
            }
            else if (funcLeftContainsRight(rb, lb))
            {
                return enContainState.RightContainLeft;
            }

            return enContainState.None;
        }
        private static bool CheckSegmentIntersection(List<ItemPoint2DF> left, List<ItemPoint2DF> right)
        {
            for (int i = 0; i < left.Count; i++)
            {
                for (int j = 0; j < right.Count; j++)
                {
                    var lMax = left.Count;
                    var rMax = right.Count;

                    var isInterSected = DoIntersect(left[i], left[(i + 1) % lMax], right[j], right[(j + 1) % rMax]);
                    if (isInterSected)
                    {
                        return true;
                    }
                }
            }

            return false;
        }
        // Given three collinear points p, q, r, the function checks if
        // point q lies on line segment 'pr'
        static Boolean OnSegment(ItemPoint2DF p, ItemPoint2DF q, ItemPoint2DF r)
        {
            if (q.X <= Math.Max(p.X, r.X) && q.X >= Math.Min(p.X, r.X) &&
                q.Y <= Math.Max(p.Y, r.Y) && q.Y >= Math.Min(p.Y, r.Y))
                return true;

            return false;
        }

        // To find orientation of ordered triplet (p, q, r).
        // The function returns following values
        // 0 --> p, q and r are collinear
        // 1 --> Clockwise
        // 2 --> Counterclockwise
        static int Orientation(ItemPoint2DF p, ItemPoint2DF q, ItemPoint2DF r)
        {
            // See https://www.geeksforgeeks.org/orientation-3-ordered-points/
            // for details of below formula.
            var val = (q.Y - p.Y) * (r.X - q.X) -
                    (q.X - p.X) * (r.Y - q.Y);

            if (val == 0) return 0; // collinear

            return (val > 0) ? 1 : 2; // clock or counterclock wise
        }

        // The main function that returns true if line segment 'p1q1'
        // and 'p2q2' intersect.
        static Boolean DoIntersect(ItemPoint2DF p1, ItemPoint2DF q1, ItemPoint2DF p2, ItemPoint2DF q2)
        {
            // Find the four orientations needed for general and
            // special cases
            int o1 = Orientation(p1, q1, p2);
            int o2 = Orientation(p1, q1, q2);
            int o3 = Orientation(p2, q2, p1);
            int o4 = Orientation(p2, q2, q1);

            // General case
            if (o1 != o2 && o3 != o4)
                return true;

            // Special Cases
            // p1, q1 and p2 are collinear and p2 lies on segment p1q1
            if (o1 == 0 && OnSegment(p1, p2, q1)) return true;

            // p1, q1 and q2 are collinear and q2 lies on segment p1q1
            if (o2 == 0 && OnSegment(p1, q2, q1)) return true;

            // p2, q2 and p1 are collinear and p1 lies on segment p2q2
            if (o3 == 0 && OnSegment(p2, p1, q2)) return true;

            // p2, q2 and q1 are collinear and q1 lies on segment p2q2
            if (o4 == 0 && OnSegment(p2, q1, q2)) return true;

            return false; // Doesn't fall in any of the above cases
        }
        public static ItemPoint2DF MinPointOf(IList<ItemPoint2DF> vertexes)
        {
            var minX = double.MaxValue;
            var minY = double.MaxValue;
            foreach (var vertex in vertexes)
            {
                minX = Math.Min(minX, vertex.X);
                minY = Math.Min(minY, vertex.Y);
            }
            return new ItemPoint2DF(minX, minY);
        }
        public static ItemPoint2DF MaxPointOf(IList<ItemPoint2DF> vertexes)
        {
            var maxX = double.MinValue;
            var maxY = double.MinValue;
            foreach (var vertex in vertexes)
            {
                maxX = Math.Max(maxX, vertex.X);
                maxY = Math.Max(maxY, vertex.Y);
            }
            return new ItemPoint2DF(maxX, maxY);
        }
    }

    public enum enContainState
    {
        None,
        LeftContainRight,
        RightContainLeft,
    }

    public class ItemPoint2DF
    {
        public double X { get; set; }
        public double Y { get; set; }

        public ItemPoint2DF(double x, double y)
        {
            X = x;
            Y = y;
        }
    }

    public static class Swap
    {
        public static void Change<T>(ref T lhs, ref T rhs)
        {
            T temp = lhs;
            lhs = rhs;
            rhs = temp;
        }
    }

    public class PolygonChecker
    {
        public static bool IsSameMesh(ICollection<ItemPoint2DF> m1, IList<ItemPoint2DF> m2)
        {
            if (m1.Count != m2.Count)
                return false;

            return !m1.Where((t, i) => !t.Equals(m2[i])).Any();
        }

        public static bool IsPolygonInPolygon(IEnumerable<ItemPoint2DF> inMesh, IList<ItemPoint2DF> outMesh)
        {
            return inMesh.All(pt => PointInPolygon(pt, outMesh));
        }

        public static bool PointInPolygon(ItemPoint2DF point, IList<ItemPoint2DF> vectorList)
        {
            var flag = false;
            var j = vectorList.Count - 1;
            for (var i = 0; i < vectorList.Count; i++)
            {
                CheckPoint(ref flag, point, vectorList[i], vectorList[j]);
                j = i;
            }

            if (vectorList.Any(point.Equals)) { flag = true; }

            return flag;
        }

        private static void CheckPoint(ref bool flag, ItemPoint2DF checkPoint, ItemPoint2DF iPoint, ItemPoint2DF jPoint)
        {
            if ((((iPoint.Y < checkPoint.Y) && (jPoint.Y >= checkPoint.Y)) ||
                 ((jPoint.Y < checkPoint.Y) && (iPoint.Y >= checkPoint.Y))) &&
                ((iPoint.X <= checkPoint.X) || (jPoint.X <= checkPoint.X)))
            {
                if (iPoint.X + (checkPoint.Y - iPoint.Y) / (jPoint.Y - iPoint.Y) * (jPoint.X - iPoint.X) < checkPoint.X)
                {
                    flag = !flag;
                }
            }
        }
    }


    public struct ScalarValueRange
    {
        public static ScalarValueRange Invalid = new ScalarValueRange(double.MaxValue, double.MinValue);

        public double Min { get; private set; }
        public double Max { get; private set; }
        public double Length { get { return Math.Abs(Max - Min); } }

        public ScalarValueRange(double min, double max)
        {
            Min = Math.Min(min, max);
            Max = Math.Max(min, max);
        }

        public bool IsIntersected(ScalarValueRange other, bool includingLimit = true)
        {
            if (includingLimit)
                return !(Max < other.Min) && !(Min > other.Max);
            else
                return !(Max <= other.Min) && !(Min >= other.Max);
        }

        public bool IsValid => Min < Max;

        public IEnumerable<double> Steps(double step)
        {
            var value = Min + step * 0.5;
            yield return value;
            while ((value + step) <= Max)
            {
                value += step;
                yield return value;
            }
        }

        public bool Contains(double value)
        {
            return value >= Min && value <= Max;
        }

        public bool ContainsExclusively(double value)
        {
            return value > Min && value < Max;
        }

        public ScalarValueRange GetIntersected(ScalarValueRange other)
        {
            if (!IsIntersected(other))
                return ScalarValueRange.Invalid;

            return new ScalarValueRange(Math.Max(Min, other.Min), Math.Min(Max, other.Max));
        }
    }

    public struct ScalarValue2D
    {
        public static ScalarValue2D Empty = new ScalarValue2D(0, 0);
        public static ScalarValue2D Unit = new ScalarValue2D(1, 1);
        public static ScalarValue2D Min = new ScalarValue2D(double.MinValue, double.MinValue);
        public static ScalarValue2D Max = new ScalarValue2D(double.MaxValue, Double.MaxValue);
        public static ScalarValue2D Invalid = new ScalarValue2D(double.MaxValue, double.MinValue);

        public ScalarValue2D(double x, double y)
        {
            X = x;
            Y = y;
        }


        public double X { get; set; }
        public double Y { get; set; }

        public override string ToString()
        {
            return string.Format("({0},{1})", X, Y);
        }

        public static ScalarValue2D operator /(ScalarValue2D obj, double divide)
        {
            return new ScalarValue2D(obj.X / divide, obj.Y / divide);
        }
        public static ScalarValue2D operator +(ScalarValue2D lhs, ScalarValue2D rhs)
        {
            return new ScalarValue2D(lhs.X + rhs.X, lhs.Y + rhs.Y);
        }
        public static ScalarValue2D operator -(ScalarValue2D lhs, ScalarValue2D rhs)
        {
            return new ScalarValue2D(lhs.X - rhs.X, lhs.Y - rhs.Y);
        }
        public static ScalarValue2D operator -(ScalarValue2D obj)
        {
            return new ScalarValue2D(-obj.X, -obj.Y);
        }

        public bool Equals(ScalarValue2D other)
        {
            //return X.Equals(other.X) && Y.Equals(other.Y);
            return Math.Abs(X - other.X) < double.Epsilon
                   && Math.Abs(Y - other.Y) < double.Epsilon
                ;
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            return obj is ScalarValue2D && Equals((ScalarValue2D)obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (X.GetHashCode() * 397) ^ Y.GetHashCode();
            }
        }

        private sealed class ScalarValue2DPositionComparer : IEqualityComparer<ScalarValue2D>
        {
            private double _tolerance;

            public ScalarValue2DPositionComparer(double tolerance = 1e-6)
            {
                _tolerance = tolerance;
            }

            public bool Equals(ScalarValue2D lhs, ScalarValue2D rhs)
            {
                return Math.Abs(lhs.X - rhs.X) < _tolerance
                       && Math.Abs(lhs.Y - rhs.Y) < _tolerance
                    ;
            }

            public int GetHashCode(ScalarValue2D obj)
            {
                unchecked
                {
                    return (obj.X.GetHashCode() * 397) ^ obj.Y.GetHashCode();
                }
            }
        }

        public static IEqualityComparer<ScalarValue2D> PositionComparer { get; } = new ScalarValue2DPositionComparer();
    }


    public struct OrthogonalBoundBox2D
    {
        public static OrthogonalBoundBox2D Empty = new OrthogonalBoundBox2D();

        public ScalarValue2D Min { get; private set; }
        public ScalarValue2D Max { get; private set; }

        public ScalarValue2D Size
        {
            get
            {
                return new ScalarValue2D(Max.X - Min.X, Max.Y - Min.Y);
            }
        }

        public ScalarValue2D CenterPos
        {
            get
            {
                return new ScalarValue2D((Min.X + Max.X) / 2, (Min.Y + Max.Y) / 2);
            }
        }

        public IEnumerable<ScalarValue2D> Points
        {
            get
            {
                yield return new ScalarValue2D(Min.X, Min.Y);
                yield return new ScalarValue2D(Min.X, Max.Y);
                yield return new ScalarValue2D(Max.X, Max.Y);
                yield return new ScalarValue2D(Max.X, Min.Y);
            }
        }

        public ScalarValueRange RangeX => new ScalarValueRange(Min.X, Max.X);
        public ScalarValueRange RangeY => new ScalarValueRange(Min.Y, Max.Y);

        public OrthogonalBoundBox2D(double minx, double miny, double maxx, double maxy)
            : this(new ScalarValue2D(minx, miny), new ScalarValue2D(maxx, maxy))
        {
        }

        public OrthogonalBoundBox2D(ScalarValue2D min, ScalarValue2D max)
        {
            Min = min;
            Max = max;
        }
    }



}

```