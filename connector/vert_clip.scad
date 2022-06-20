height = 10;   // linear extrude
left = 2;      // left side
hold = 4;      // lenght of the "middle" part
hold_plus = 3; // amount of "hold" thats really holding
right = 4;     // right side
base = 6;
// base_plus = 1;
tol = 0;
add = 2;

module vert_clip_neg_2d(left = left,           // left side
                        hold = hold,           // lenght of the "middle" part
                        hold_plus = hold_plus, // amount of "hold" thats really holding
                        right = right,         // right side
                        base = base, tol = tol, add = add, )
{
    diff_base = max((left + hold - base), 0);
    translate([ 0, -(2 * (hold + hold_plus) - hold), 0 ]) offset(tol)

        // get_points();

        polygon(points = [
            // base
            [ base, -diff_base ],         // right-top
            [ base, -diff_base - right ], // right-bottom

            [ left + hold + hold_plus + right, hold_plus ], // outer righ end
            // [left+right,2*(hold+hold_plus)-hold],     //outer upper end

            // [base,2*(hold+hold_plus)-hold],          //right-upper-top
            // [0,2*(hold+hold_plus)-hold],             //left-top
            // [0,2*(hold+hold_plus)-hold+base],             //left-top
            [ 0, hold + left + hold + hold_plus + right ], // left-top

            [ 0, -diff_base - right ], // left-bottom
            [ 0, -diff_base ],         // left-top

            // add
            [ left + add, hold_plus ], [ left, hold_plus + add ],

            [ left, 2 * (hold + hold_plus) - hold ], // inner upper end
            [ left + hold + hold_plus, hold_plus ],  // inner righ end
            [ left + hold, 0 ]                       // back to base
        ]);
}
module vert_clip_neg(height = height,       // linear extrude
                     left = left,           // left side
                     hold = hold,           // lenght of the "middle" part
                     hold_plus = hold_plus, // amount of "hold" thats really holding
                     right = right,         // right side
                     base = base, tol = tol, add = add, )
{
    linear_extrude(height) vert_clip_neg_2d(left = left,           // left side
                                            hold = hold,           // lenght of the "middle" part
                                            hold_plus = hold_plus, // amount of "hold" thats really holding
                                            right = right,         // right side
                                            base = base, tol = tol, add = add);
}

module vert_clip_pos_2d(left = left,           // left side
                        hold = hold,           // lenght of the "middle" part
                        hold_plus = hold_plus, // amount of "hold" thats really holding
                        base = base,
                        // base_plus=base_plus,
                        tol = tol, add = add, )
{
    diff_base = max((left + hold - base), 0);
    translate([ 0, diff_base, 0 ])
    {
        offset(tol)
        {

            // get_points();

            polygon(points = [
                // base
                //  [base,-diff_base],          //right-top
                //  [base,-diff_base-right],    //right-bottom
                //  [0,-diff_base-right],       //left-bottom
                //  [0,-base-left],       //left-bottom
                [ 0, -diff_base ], // left-top

                // add
                [ left + add, hold_plus ], [ left, hold_plus + add ],

                [ left, 2 * (hold + hold_plus) - hold ], [ left + hold + hold_plus, hold_plus ],
                // [left+hold,0]
                // [0,-left],
                // [left+hold,0]
                [ 0, -(left + hold) ]
            ]);
        }
    }
}

module vert_clip_pos(height = height,       // linear extrude
                     left = left,           // left side
                     hold = hold,           // lenght of the "middle" part
                     hold_plus = hold_plus, // amount of "hold" thats really holding
                     base = base,
                     // base_plus=base_plus,
                     tol = tol, add = add)
{

    /*

      |\
      |  \
       \   \
       /   /
    __|  /__
    |       |
    |       |

    */

    linear_extrude(height)
    {
        vert_clip_pos_2d(left = left,           // left side
                         hold = hold,           // lenght of the "middle" part
                         hold_plus = hold_plus, // amount of "hold" thats really holding
                         base = base,
                         // base_plus=base_plus,
                         tol = tol, add = add);
    }
}

module test_clip(height = height, left = left, hold = hold, hold_plus = hold_plus, base = base,
                 // base_plus=base_plus,
                 tol = tol, add = add, )
{

    diff_base = max((left + hold - base), 0);
    // translate([0,-diff_base,0])
    vert_clip_pos(height = height, left = left, hold = hold, hold_plus = hold_plus, base = base,
                  // base_plus    = base_plus,
                  tol = -0.2, add = add);

    translate([ 0, (2 * (hold + hold_plus) - hold), 0 ]) translate([ 0, diff_base, 0 ])

        vert_clip_neg(height = height, left = left, hold = hold, hold_plus = hold_plus, base = base,
                      // base    = base_plus,
                      tol = tol, add = add);
}
// Doesn't work
// Idea was functionallity like #define
//  function get_points(){
//  points=[

//         //base
//         [base,-diff_base],
//         [0,-diff_base],

//         // [left,0],

//         //add
//         // [left,hold_plus-add],
//         [left+add,hold_plus],
//         [left,hold_plus+add],

//         [left,2*(hold+hold_plus)-hold],
//         [left+hold+hold_plus,hold_plus],
//         [left+hold,0],

//     ];
// }