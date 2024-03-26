external ffInputToSelectInput: ReactFinalForm.fieldRenderPropsInput => ReactFinalForm.fieldRenderPropsCustomInput<
  array<string>,
> = "%identity"

let startYear = ref(2016)
let years = []
while Date.make()->Js.Date.getFullYear->Float.toInt >= startYear.contents {
  years->Array.push(startYear.contents)->ignore
  startYear := startYear.contents + 1
}
years->Js.Array2.reverseInPlace->ignore

let months: array<InfraCalendar.month> = [
  Jan,
  Feb,
  Mar,
  Apr,
  May,
  Jun,
  Jul,
  Aug,
  Sep,
  Oct,
  Nov,
  Dec,
]

let getMonthInStr = (mon: InfraCalendar.month) => {
  switch mon {
  | Jan => "January, "
  | Feb => "February, "
  | Mar => "March, "
  | Apr => "April, "
  | May => "May, "
  | Jun => "June, "
  | Jul => "July, "
  | Aug => "August, "
  | Sep => "September, "
  | Oct => "October, "
  | Nov => "November, "
  | Dec => "December, "
  }
}

let getMonthFromFloat = value => {
  let valueInt = value->Float.toInt
  months[valueInt]->Option.getOr(Jan)
}
module YearItem = {
  @send external scrollIntoView: Dom.element => unit = "scrollIntoView"

  @react.component
  let make = (~tempYear, ~year, ~handleChangeMonthBy, ~setCurrDate, ~tempMonth) => {
    let isSelected = year->Int.toFloat === tempYear
    let yearRef = React.useRef(Nullable.null)

    React.useEffect1(() => {
      if isSelected {
        switch yearRef.current->Nullable.toOption {
        | Some(element) => element->scrollIntoView
        | None => ()
        }
      }
      None
    }, [isSelected])

    <li
      className={`p-2 ${year === tempYear->Float.toInt
          ? "bg-blue-600 text-white"
          : "dark:hover:bg-jp-gray-900 hover:bg-jp-gray-100"} cursor-pointer bg-opacity-100`}
      value={year->Int.toString}
      ref={yearRef->ReactDOM.Ref.domRef}
      onClick={e => {
        let tar: float = ReactEvent.Mouse.currentTarget(e)["value"]
        let yearDiff = (tar -. tempYear)->Float.toInt
        if yearDiff !== 0 {
          handleChangeMonthBy(yearDiff * 12)
          setCurrDate(_ => Js.Date.makeWithYM(~year=tar, ~month=tempMonth, ()))
        }
      }}>
      {year->Int.toString->React.string}
    </li>
  }
}

module MonthItem = {
  @send external scrollIntoView: Dom.element => unit = "scrollIntoView"

  @react.component
  let make = (
    ~index,
    ~tempMonth: float,
    ~tempYear,
    ~handleChangeMonthBy,
    ~setCurrDate,
    ~mon: InfraCalendar.month,
  ) => {
    let isSelected = index->Int.toFloat === tempMonth
    let monthRef = React.useRef(Nullable.null)

    React.useEffect1(() => {
      if isSelected {
        switch monthRef.current->Nullable.toOption {
        | Some(element) => element->scrollIntoView
        | None => ()
        }
      }
      None
    }, [isSelected])

    <li
      value={index->Int.toString}
      onClick={e => {
        let tar: float = ReactEvent.Mouse.currentTarget(e)["value"]
        let monthDiff = (tar -. tempMonth)->Float.toInt
        if monthDiff !== 0 {
          handleChangeMonthBy(monthDiff)
          setCurrDate(_ => Js.Date.makeWithYM(~year=tempYear, ~month=tar, ()))
        }
      }}
      ref={monthRef->ReactDOM.Ref.domRef}
      className={`p-2 px-4 ${index === tempMonth->Float.toInt
          ? "bg-blue-600 text-white"
          : "dark:hover:bg-jp-gray-900 hover:bg-jp-gray-100"}  cursor-pointer`}>
      {mon->getMonthInStr->String.replaceRegExp(%re("/,/g"), "")->React.string}
    </li>
  }
}

open InfraCalendar
@react.component
let make = (
  ~month as _: option<month>=?,
  ~year as _: option<int>=?,
  ~onDateClick=?,
  ~cellHighlighter=?,
  ~cellRenderer=?,
  ~startDate="",
  ~endDate="",
  ~disablePastDates=true,
  ~disableFutureDates=false,
  ~monthYearListVisibility,
  ~handleChangeMonthBy,
  ~currDateIm,
  ~setCurrDate,
) => {
  <span
    className="flex flex-1 flex-row overflow-auto border-t border-b dark:border-jp-gray-900 select-none">
    {
      let currDateTemp = Js.Date.fromFloat(Js.Date.valueOf(currDateIm))
      let tempDate = Js.Date.setMonth(
        currDateTemp,
        Int.toFloat(Float.toInt(Js.Date.getMonth(currDateTemp))),
      )
      let tempMonth = Js.Date.getMonth(Js.Date.fromFloat(tempDate))
      let tempYear = Js.Date.getFullYear(Js.Date.fromFloat(tempDate))

      <span>
        {monthYearListVisibility
          ? <div className="flex text-jp-gray-600 justify-between w-80">
              <ul className="w-1/2 h-80 overflow-scroll">
                {months
                ->Array.mapWithIndex((mon, i) =>
                  <MonthItem
                    key={i->Int.toString}
                    index=i
                    tempMonth
                    tempYear
                    handleChangeMonthBy
                    setCurrDate
                    mon
                  />
                )
                ->React.array}
              </ul>
              <ul className="w-1/2">
                {years
                ->Array.mapWithIndex((year, i) =>
                  <YearItem
                    key={i->Int.toString} tempMonth tempYear handleChangeMonthBy year setCurrDate
                  />
                )
                ->React.array}
              </ul>
            </div>
          : <InfraCalendar
              month={getMonthFromFloat(tempMonth)}
              year={Float.toInt(tempYear)}
              showTitle=false
              ?cellHighlighter
              ?cellRenderer
              ?onDateClick
              startDate
              endDate
              disablePastDates
              disableFutureDates
            />}
      </span>
    }
  </span>
}
